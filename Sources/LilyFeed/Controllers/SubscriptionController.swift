//
//  SubscriptionController.swift
//  
//
//  Created by Bunga Mungil on 20/06/23.
//

import Vapor
import WebSubSubscriber


struct SubscriptionController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let routesGroup = routes.grouped("subscriptions")
        routesGroup.get("", use: index)
    }
    
    func index(req: Request) async throws -> View {
        return try await req.view
            .render("subscriptions-index", [
                "subscriptions": SubscriptionModel.query(on: req.db).paginate(for: req).items
            ])
    }
    
}
