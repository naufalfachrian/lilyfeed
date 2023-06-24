//
//  DiscordWebhook.swift
//  
//
//  Created by Bunga Mungil on 23/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


protocol DiscordWebhook {
    
    typealias CreateRequest = CreateDiscordWebhookRequest
    
    typealias UpdateRequest = UpdateDiscordWebhookRequest
    
    var forSubscription: Subscription? { get }
    
    var webhookURL: String { get }
    
    var roleIDToMention: String { get }
        
    var lastPublishAt: Date? { get }
    
}


struct CreateDiscordWebhookRequest: Codable {
    
    let subscriptionID: UUID
    
    let webhookURL: String
    
    let roleIDToMention: String
    
    enum CodingKeys: String, CodingKey {
        case subscriptionID = "subscription_id"
        case webhookURL = "webhook_url"
        case roleIDToMention = "role_id_to_mention"
    }
    
}


extension CreateDiscordWebhookRequest: Content { }


extension CreateDiscordWebhookRequest {
    
    func create(on db: Database) async throws -> DiscordWebhookModel {
        let created = DiscordWebhookModel(
            subscriptionID: self.subscriptionID,
            webhookURL: self.webhookURL,
            roleIDToMention: self.roleIDToMention
        )
        try await created.save(on: db)
        return created
    }
    
}


struct UpdateDiscordWebhookRequest: Codable {
    
    let webhookURL: String?
    
    let roleIDToMention: String?
    
    enum CodingKeys: String, CodingKey {
        case webhookURL = "webhook_url"
        case roleIDToMention = "role_id_to_mention"
    }
    
}


extension UpdateDiscordWebhookRequest: Content { }


extension UpdateDiscordWebhookRequest {
    
    func update(_ id: UUID, on db: Database) async throws -> DiscordWebhookModel {
        guard let updated = try await DiscordWebhookModel.find(id, on: db) else {
            throw HTTPResponseStatus.notFound
        }
        if let updateWebhookURL = self.webhookURL {
            updated.webhookURL = updateWebhookURL
        }
        if let updateRoleIDToMention = self.roleIDToMention {
            updated.roleIDToMention = updateRoleIDToMention
        }
        try await updated.update(on: db)
        return updated
    }
    
}
