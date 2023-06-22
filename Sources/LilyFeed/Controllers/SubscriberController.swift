//
//  SubscriberController.swift
//  
//
//  Created by Bunga Mungil on 20/06/23.
//

import Vapor
import WebSubSubscriber


struct SubscriberController: SubscriberRouteCollection, UseRequestParser {
    
    let path: PathComponent = ""
    
    func boot(routes: RoutesBuilder) throws {
        try self.setup(routes: routes, middlewares: [
            UserBasicAuthenticator(),
            UserModel.guardMiddleware()
        ])
    }
    
    func payload(_ payload: Request, from subscription: SubscriptionModel) async throws -> Response {
        payload.logger.info(
            """
            Payload received on LilyFeed's userspace from request: \(payload.id)
            """
        )
        switch try await self.parse(payload, for: subscription) {
        case .success(let videos):
            payload.logger.info(
                """
                \(videos.count) saved from request: \(payload.id)!
                """
            )
            break
        case .failure(let reason):
            payload.logger.info(
                """
                \(reason.localizedDescription) occurred when parsing payload on request: \(payload.id)!
                """
            )
            break
        }
        return Response(status: .noContent)
    }
    
}
