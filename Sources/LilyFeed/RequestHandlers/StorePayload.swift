//
//  StorePayload.swift
//  
//
//  Created by Bunga Mungil on 28/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


struct StorePayload {
    
    let videos: [any YoutubeVideo & Model]
    
    let subscription: SubscriptionModel
    
}


extension StorePayload: RequestHandler {
    
    typealias ResultType = ([any YoutubeVideo & Model], SubscriptionModel)
    
    func handle(on req: Request) async -> Result<([any YoutubeVideo & Model], SubscriptionModel), ErrorResponse> {
        do {
            for video in videos {
                try await video.save(on: req.db)
            }
            return .success((self.videos, self.subscription))
        } catch {
            return .failure(.init(code: .noContent))
        }
    }
    
}
