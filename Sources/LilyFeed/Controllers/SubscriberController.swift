//
//  SubscriberController.swift
//  
//
//  Created by Bunga Mungil on 20/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


struct SubscriberController: SubscriberRouteCollection, UseRequestParser {
    
    let path: PathComponent = ""
    
    func boot(routes: RoutesBuilder) throws {
        try self.setup(routes: routes, middlewares: [
            UserBasicAuthenticator(),
            UserModel.guardMiddleware()
        ])
    }
    
    func payload(_ payload: Request, from subscription: SubscriptionModel) async throws -> Response {
        payload.logger.info(
            """
            Payload received on LilyFeed's userspace from request: \(payload.id)
            """
        )
        switch try await self.parse(payload, for: subscription) {
        case .success(let videos):
            payload.logger.info(
                """
                \(videos.count) saved from request: \(payload.id)!
                """
            )
            try await self.hook(videos, from: subscription, on: payload.db, with: payload.client, logger: payload.logger)
            break
        case .failure(let reason):
            payload.logger.info(
                """
                \(reason.localizedDescription) occurred when parsing payload on request: \(payload.id)!
                """
            )
            break
        }
        return Response(status: .noContent)
    }
    
}


fileprivate extension SubscriberController {
    
    func hook(_ videos: [YoutubeVideo], from subscription: SubscriptionModel, on db: Database, with client: Client, logger: Logger? = nil) async throws {
        guard let discordWebhook = try await DiscordWebhookModel.query(on: db)
            .filter(\.$subscription.$id, .equal, subscription.id)
            .first()
        else {
            return
        }
        for youtube in videos {
            let content = "<@&\(discordWebhook.roleIDToMention)> \(youtube.videoTitle) \(youtube.videoURL)"
            let response = try await client.post(
                URI(string: "\(discordWebhook.webhookURL)?wait=true"),
                content: WebhookRequest(
                    content: content
                )
            )
            logger?.info(
                """
                Video: \(youtube.videoTitle)
                Send to: \(discordWebhook.webhookURL)
                """
            )
            if response.status == .ok {
                discordWebhook.lastPublishAt = Date()
                try await discordWebhook.save(on: db)
                logger?.info(
                    """
                    Video: \(youtube.videoTitle)
                    Send to: \(discordWebhook.webhookURL)
                    Success!
                    """
                )
            } else {
                logger?.info(
                    """
                    Video: \(youtube.videoTitle)
                    Send to: \(discordWebhook.webhookURL)
                    Failed with status: \(response.status.stringValue)
                    """
                )
            }
        }
    }
    
}
