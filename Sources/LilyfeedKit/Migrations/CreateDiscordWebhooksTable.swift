//
//  CreateDiscordWebhooksTable.swift
//  
//
//  Created by Bunga Mungil on 23/06/23.
//

import Fluent


public struct CreateDiscordWebhooksTable: AsyncMigration {
    
    public func prepare(on database: Database) async throws {
        try await database.schema("discord_webhooks")
            .id()
            .field("subscription_id", .uuid, .references("subscriptions", "id"))
            .field("webhook_url", .string, .required)
            .field("role_id_to_mention", .string, .required)
            .field("last_publish_at", .datetime)
            .field("created_at", .datetime, .required)
            .unique(on: "webhook_url")
            .create()
    }
    
    public func revert(on database: Database) async throws {
        try await database.schema("discord_webhooks").delete()
    }
    
    public init() { }
    
}
