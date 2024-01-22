//
//  SubscriberController.swift
//  
//
//  Created by Bunga Mungil on 20/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


public struct SubscriberController:
        SubscriberRouteCollection,
        ParsingPayload,
        StoringPayload,
        FindingHook
{
    
    public init() { }
    
    public let path: PathComponent = ""
    
    public func boot(routes: RoutesBuilder) throws {
        try self.setup(routes: routes, middlewares: [
            UserBasicAuthenticator(),
            UserModel.guardMiddleware()
        ])
    }
    
    public func receiving(from request: Request, received: (validPayload: Request, subscription: SubscriptionModel)) async throws -> Response {
        request.logger.info(
            """
            Payload received on LilyFeed's userspace from request: \(request.id)
            """
        )
        try await request.queue.dispatch(
            ReceivingPayloadJob.self,
            .init(
                data: received.validPayload.body.data,
                subscription: received.subscription
            )
        )
        return try await self.parsing(from: received.validPayload, for: received.subscription)
    }
    
    func parsed(from request: Request, parsed: (videos: [any YoutubeVideo & Model], subscription: SubscriptionModel)) async throws -> Response {
        request.logger.info(
            """
            Payload parsed from request: \(request.id)
            # of video entries: \(parsed.videos.count)
            \(parsed.videos.ids(separator: ","))
            """
        )
        parsed.videos.forEach { video in
            _ = request.queue.dispatch(ReceiveYoutubeVideoJob.self, .init(from: video))
        }
        return try await self.storing(from: request, for: parsed)
    }
    
    func stored(from request: Request, stored: (videos: [any YoutubeVideo & Model], subscription: SubscriptionModel)) async throws -> Response {
        request.logger.info(
            """
            Payload stored from request: \(request.id)
            # of video entries: \(stored.videos.count)
            \(stored.videos.ids(separator: ","))
            """
        )
        return try await self.findingHook(from: request, for: stored)
    }
    
    func hooked(from request: Request, for hook: Hook) async throws -> Response {
        switch hook {
        case .found(let webhook, let videos):
            request.logger.info(
                """
                Payload hooked from request: \(request.id)
                via: \(webhook.webhookURL)
                # of video entries: \(videos.count)
                \(videos.ids(separator: ","))
                """
            )
        }
        return Response(status: .noContent)
    }
    
}
