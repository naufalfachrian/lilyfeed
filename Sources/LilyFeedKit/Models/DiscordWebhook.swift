//
//  DiscordWebhook.swift
//  
//
//  Created by Bunga Mungil on 23/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


public protocol DiscordWebhook {
    
    typealias CreateRequest = CreateDiscordWebhookRequest
    
    typealias UpdateRequest = UpdateDiscordWebhookRequest
    
    var forSubscription: Subscription? { get }
    
    var webhookURL: String { get }
    
    var roleIDToMention: String { get }
        
    var lastPublishAt: Date? { get }
    
    func updatePublishAt(on db: Database) async throws
    
}


// MARK: - Create Discord Webhook Request

public struct CreateDiscordWebhookRequest: Codable {
    
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
    
    public func create(on db: Database) async throws -> DiscordWebhookModel {
        let created = DiscordWebhookModel(
            subscriptionID: self.subscriptionID,
            webhookURL: self.webhookURL,
            roleIDToMention: self.roleIDToMention
        )
        try await created.save(on: db)
        return created
    }
    
}


// MARK: - Update Discord Webhook Request

public struct UpdateDiscordWebhookRequest: Codable {
    
    let webhookURL: String?
    
    let roleIDToMention: String?
    
    enum CodingKeys: String, CodingKey {
        case webhookURL = "webhook_url"
        case roleIDToMention = "role_id_to_mention"
    }
    
}


extension UpdateDiscordWebhookRequest: Content { }


extension UpdateDiscordWebhookRequest {
    
    public func update(_ id: UUID, on db: Database) async throws -> DiscordWebhookModel {
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


// MARK: - Discord Webhook Model

public final class DiscordWebhookModel: DiscordWebhook, Model, Content {
    
    public static var schema: String = "discord_webhooks"
    
    @ID(key: .id)
    public var id: UUID?
    
    @OptionalParent(key: "subscription_id")
    public var subscription: SubscriptionModel?
    
    @Field(key: "webhook_url")
    public var webhookURL: String
    
    @Field(key: "role_id_to_mention")
    public var roleIDToMention: String
    
    @Field(key: "last_publish_at")
    public var lastPublishAt: Date?
    
    @Field(key: "created_at")
    public var createdAt: Date?
    
    public var forSubscription: Subscription? {
        return self.subscription
    }
    
    public init() { }
    
    public init(
        subscriptionID: UUID?,
        webhookURL: String,
        roleIDToMention: String
    ) {
        self.$subscription.id = subscriptionID
        self.webhookURL = webhookURL
        self.roleIDToMention = roleIDToMention
        self.lastPublishAt = nil
        self.createdAt = Date()
    }
    
    public func updatePublishAt(on db: Database) async throws {
        self.lastPublishAt = Date()
        try await self.save(on: db)
    }
    
}
