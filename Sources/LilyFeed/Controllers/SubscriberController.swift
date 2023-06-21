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
    
    func payload(for subscription: Subscription, on req: Request) async throws -> Response {
        req.logger.info(
            """
            Payload received on LilyFeed's userspace from request: \(req.id)
            """
        )
        switch try await self.parse(req, for: subscription) {
        case .success(let videos):
            req.logger.info(
                """
                \(videos.count) saved from request: \(req.id)!
                """
            )
            break
        case .failure(let reason):
            req.logger.info(
                """
                \(reason.localizedDescription) occurred when parsing payload on request: \(req.id)!
                """
            )
            break
        }
        return Response(status: .noContent)
    }
    
}
