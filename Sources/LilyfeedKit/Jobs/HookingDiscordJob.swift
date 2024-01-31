//
//  HookingDiscordJob.swift
//
//
//  Created by Bunga Mungil on 31/01/24.
//

import Foundation
import Vapor
import Queues


public struct HookingDiscordJob: AsyncJob {
    
    public init() {
    }
    
    public typealias Payload = YouTubeVideoModel
    
    public func dequeue(_ context: QueueContext, _ payload: YouTubeVideoModel) async throws {
        guard let discordWebHook = try await DiscordWebhookModel.query(on: context.application.db)
            .filter(\.$subscription.$id, .equal, payload.$subscription.id)
            .first()
        else {
            return
        }
        let content = "<@&\(discordWebHook.roleIDToMention)> \(payload.videoTitle) \(payload.videoURL)"
        if !payload.wasPublishedLast24Hours {
            context.logger.info(
                """
                Discord WebHook not delivered to \(discordWebHook.webhookURL)!
                Video with title \"\(payload.videoTitle)\" was published more than 24 hours ago.
                """
            )
            return
        }
        let response = try await context.application.client.post(
            URI(string: "\(discordWebHook.webhookURL)?wait=true"),
            content: WebhookRequest(
                content: content
            )
        )
        context.logger.info(
            """
            Video with title \"\(payload.videoTitle)\" has been delivered
            via Discord WebHook to \(discordWebHook.webhookURL)
            """
        )
        if response.status == .ok {
            try await discordWebHook.updatePublishAt(on: context.application.db)
        } else {
            context.logger.error(
                """
                Video with title \"\(payload.videoTitle)\" has been delivered
                via Discord WebHook to \(discordWebHook.webhookURL)
                but failed with response \(response.status)
                """
            )
        }
    }
    
}
