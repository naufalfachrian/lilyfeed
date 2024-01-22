//
//  ParsingPayload.swift
//  
//
//  Created by Bunga Mungil on 28/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


protocol ParsingPayload {
    
    func parsing(from request: Request, for subscription: SubscriptionModel) async throws -> Response
    
    func parsed(from request: Request, parsed: (videos: [any YouTubeVideo & Model], subscription: SubscriptionModel)) async throws -> Response
    
}


extension ParsingPayload {
    
    func parsing(from request: Request, for subscription: SubscriptionModel) async throws -> Response {
        return try await ParsePayload(request, for: subscription).handle(on: request, then: self.parsed)
    }
    
}
