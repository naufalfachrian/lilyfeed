//
//  FindHook.swift
//  
//
//  Created by Bunga Mungil on 28/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


struct FindHook {
    
    let videos: [any YoutubeVideo & Model]
    
    let subscription: SubscriptionModel
    
}


extension FindHook: RequestHandler {
    
    typealias ResultType = Hook
    
    func handle(on req: Request) async -> Result<Hook, ErrorResponse> {
        do {
            guard let discordWebhook = try await DiscordWebhookModel.query(on: req.db)
                .filter(\.$subscription.$id, .equal, self.subscription.id)
                .first()
            else {
                throw HTTPResponseStatus.noContent
            }
            return .success(.found(discordWebhook, self.videos))
        } catch {
            return .failure(.init(code: .noContent))
        }
    }
    
}
