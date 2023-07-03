//
//  DiscordWebhookController.swift
//  
//
//  Created by Bunga Mungil on 23/06/23.
//

import Foundation
import Vapor


public struct DiscordWebhookController: RouteCollection {
    
    public init() { }
    
    public func boot(routes: RoutesBuilder) throws {
        let protectedRoutes = routes
            .grouped([
                UserBasicAuthenticator(),
                UserModel.guardMiddleware()
            ])
        protectedRoutes.group("discord-webhooks") { builder in
            builder.get(use: self.index)
            builder.post(use: self.create)
            builder.group(":id") { subBuilder in
                subBuilder.put(use: self.update)
                subBuilder.patch(use: self.update)
                subBuilder.delete(use: self.delete)
            }
        }
    }
    
    func index(req: Request) async throws -> Response {
        let items = try await DiscordWebhookModel.query(on: req.db)
            .paginate(for: req)
        return try await items.encodeResponse(for: req)
    }
    
    func create(req: Request) async throws -> Response {
        let createRequest = try req.content.decode(DiscordWebhook.CreateRequest.self)
        return try await createRequest
            .create(on: req.db)
            .encodeResponse(for: req)
    }
    
    func update(req: Request) async throws -> Response {
        guard let uuidString = req.parameters.get("id"),
              let uuid = UUID(uuidString: uuidString)
        else {
            return Response(status: .notFound)
        }
        let updateRequest = try req.content.decode(DiscordWebhook.UpdateRequest.self)
        return try await updateRequest
            .update(uuid, on: req.db)
            .encodeResponse(for: req)
    }
    
    func delete(req: Request) async throws -> Response {
        guard let uuidString = req.parameters.get("id"),
              let uuid = UUID(uuidString: uuidString)
        else {
            return Response(status: .notFound)
        }
        guard let deleted = try await DiscordWebhookModel
            .find(uuid, on: req.db)
        else {
            return Response(status: .notFound)
        }
        try await deleted.delete(on: req.db)
        return Response(status: .noContent)
    }
    
}
