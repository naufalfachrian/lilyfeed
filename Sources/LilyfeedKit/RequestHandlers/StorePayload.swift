//
//  StorePayload.swift
//  
//
//  Created by Bunga Mungil on 28/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


public struct StorePayload {
    
    let videos: [any YoutubeVideo & Model]
    
    let subscription: SubscriptionModel
    
}


extension StorePayload: RequestHandler {
    
    public typealias ResultType = ([any YoutubeVideo & Model], SubscriptionModel)
    
    public func handle(on req: Request) async -> Result<([any YoutubeVideo & Model], SubscriptionModel), ErrorResponse> {
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
