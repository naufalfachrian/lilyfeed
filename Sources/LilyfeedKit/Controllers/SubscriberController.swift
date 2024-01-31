//
//  SubscriberController.swift
//  
//
//  Created by Bunga Mungil on 20/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


public struct SubscriberController: SubscriberRouteCollection {
    
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
        return Response(status: .noContent)
    }
    
}
