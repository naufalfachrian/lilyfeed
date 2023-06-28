//
//  SubscriberController.swift
//  
//
//  Created by Bunga Mungil on 20/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


struct SubscriberController: SubscriberRouteCollection, ParsingPayload, StoringPayload {
    
    let path: PathComponent = ""
    
    func boot(routes: RoutesBuilder) throws {
        try self.setup(routes: routes, middlewares: [
            UserBasicAuthenticator(),
            UserModel.guardMiddleware()
        ])
    }
    
    func receiving(from request: Request, received: (validPayload: Request, subscription: SubscriptionModel)) async throws -> Response {
        request.logger.info(
            """
            Payload received on LilyFeed's userspace from request: \(request.id)
            """
        )
        return try await self.parsing(from: received.validPayload, for: received.subscription)
    }
    
    func parsed(from request: Request, parsed: (videos: [any YoutubeVideo & Model], subscription: SubscriptionModel)) async throws -> Response {
        return try await self.storing(from: request, for: parsed)
    }
    
    func stored(from request: Request, stored: (videos: [any YoutubeVideo & Model], subscription: SubscriptionModel)) async throws -> Response {
        try await self.hook(stored.videos, from: stored.subscription, on: request.db, with: request.client, logger: request.logger)
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
                    Failed with status: \(response.status)
                    """
                )
            }
        }
    }
    
}
