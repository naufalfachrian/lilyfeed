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
        let routesGrouped = routes.grouped(UserBasicAuthenticator())
            .grouped(UserModel.guardMiddleware())
        try self.setup(routes: routesGrouped)
    }
    
    func payload(for subscription: Subscription, on req: Request) async throws -> Response {
        req.logger.info(
        """
            Payload received on LilyFeed's userspace: \(req.body)
        """
        )
        switch try await self.parse(req, for: subscription) {
        case .success(let videos):
            req.logger.info(
            """
                \(videos.count) saved!
            """
            )
            break
        case .failure(let reason):
            req.logger.info(
            """
                \(reason.localizedDescription) occurred parsing payload!
            """
            )
            break
        }
        return Response(status: .noContent)
    }
    
}
