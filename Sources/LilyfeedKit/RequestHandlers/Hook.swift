//
//  FoundHook.swift
//  
//
//  Created by Bunga Mungil on 28/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


public enum Hook {
    
    case found(any DiscordWebhook & Model, [any YoutubeVideo & Model])

}


extension Hook: RequestHandler {
    
    public typealias ResultType = Hook
    
    public func handle(on req: Request) async -> Result<Hook, ErrorResponse> {
        do {
            switch self {
            case .found(let discordWebhook, let videos):
                for youtube in videos {
                    let content = "<@&\(discordWebhook.roleIDToMention)> \(youtube.videoTitle) \(youtube.videoURL)"
                    let response = try await req.client.post(
                        URI(string: "\(discordWebhook.webhookURL)?wait=true"),
                        content: WebhookRequest(
                            content: content
                        )
                    )
                    req.logger.info(
                        """
                        Video: \(youtube.videoTitle)
                        Send to: \(discordWebhook.webhookURL)
                        """
                    )
                    if response.status == .ok {
                        try await discordWebhook.updatePublishAt(on: req.db)
                        req.logger.info(
                            """
                            Video: \(youtube.videoTitle)
                            Send to: \(discordWebhook.webhookURL)
                            Success!
                            """
                        )
                        return .success(self)
                    } else {
                        req.logger.info(
                            """
                            Video: \(youtube.videoTitle)
                            Send to: \(discordWebhook.webhookURL)
                            Failed with status: \(response.status)
                            """
                        )
                    }
                }
                return .failure(.init(code: .noContent))
            }
        } catch {
            return .failure(.init(code: .noContent))
        }
    }
    
}
