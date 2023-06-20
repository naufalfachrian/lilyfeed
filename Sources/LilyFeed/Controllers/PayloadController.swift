//
//  PayloadController.swift
//  
//
//  Created by Bunga Mungil on 20/06/23.
//

import Vapor


struct PayloadController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let routesGroup = routes.grouped("payloads")
        routesGroup.get("", use: index)
    }
    
    func index(req: Request) async throws -> View {
        return try await req.view
            .render("payloads-index", [
                "payloads": PayloadModel.query(on: req.db).paginate(for: req).items
            ])
    }
    
}
