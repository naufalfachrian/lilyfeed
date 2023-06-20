//
//  SubscriberController.swift
//  
//
//  Created by Bunga Mungil on 20/06/23.
//

import Vapor
import WebSubSubscriber


struct SubscriberController: SubscriberRouteCollection {
    
    let path: PathComponent = ""
    
    func payload(req: Request) async throws -> Response {
        let payload = PayloadModel(
            callback: req.url.string,
            content: req.body.string ?? ""
        )
        try await payload.save(on: req.db)
        return Response(status: .noContent)
    }
    
}
