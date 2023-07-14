//
//  StoringPayload.swift
//  
//
//  Created by Bunga Mungil on 28/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


protocol StoringPayload {
    
    func storing(from request: Request, for payload: (videos: [any YoutubeVideo & Model], subscription: SubscriptionModel)) async throws -> Response
    
    func stored(from request: Request, stored: (videos: [any YoutubeVideo & Model], subscription: SubscriptionModel)) async throws -> Response
    
}


extension StoringPayload {
    
    func storing(from request: Request, for payload: (videos: [any YoutubeVideo & Model], subscription: SubscriptionModel)) async throws -> Response {
        return try await StorePayload(
            videos: payload.videos,
            subscription: payload.subscription
        ).handle(on: request, then: self.stored)
    }
    
}
