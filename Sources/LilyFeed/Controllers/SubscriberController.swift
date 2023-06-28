//
//  SubscriberController.swift
//  
//
//  Created by Bunga Mungil on 20/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


struct SubscriberController:
        SubscriberRouteCollection,
        ParsingPayload,
        StoringPayload,
        FindingHook
{
    
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
        return try await self.findingHook(from: request, for: stored)
    }
    
    func hooked(from request: Request, for hook: Hook) async throws -> Response {
        return Response(status: .noContent)
    }
    
}
