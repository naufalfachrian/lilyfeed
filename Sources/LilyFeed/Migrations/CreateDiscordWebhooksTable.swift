//
//  CreateDiscordWebhooksTable.swift
//  
//
//  Created by Bunga Mungil on 23/06/23.
//

import Fluent


struct CreateDiscordWebhooksTable: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("discord_webhooks")
            .id()
            .field("subscription_id", .uuid, .references("subscriptions", "id"))
            .field("webhook_url", .string, .required)
            .field("last_publish_at", .datetime)
            .field("created_at", .datetime, .required)
            .field("updated_at", .datetime)
            .unique(on: "webhook_url")
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("discord_webhooks").delete()
    }
    
}
