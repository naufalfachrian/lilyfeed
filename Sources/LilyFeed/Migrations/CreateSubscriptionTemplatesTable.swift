//
//  CreateSubscriptionTemplatesTable.swift
//  
//
//  Created by Bunga Mungil on 02/07/23.
//

import Fluent


public struct CreateSubscriptionTemplatesTable: AsyncMigration {
    
    public func prepare(on database: Database) async throws {
        try await database.schema("subscription_templates")
            .id()
            .field("name", .string, .required)
            .field("topic", .string, .required)
            .field("hub", .string)
            .field("lease_seconds", .int)
            .field("discord_webhook_url", .string, .required)
            .field("discord_role_id_to_mention", .string, .required)
            .field("is_active", .bool, .required)
            .create()
    }
    
    public func revert(on database: Database) async throws {
        try await database.schema("subscription_templates").delete()
    }
    
}
