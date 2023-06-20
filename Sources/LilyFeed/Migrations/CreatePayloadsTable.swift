//
//  CreatePayloadsTable.swift
//  
//
//  Created by Bunga Mungil on 20/06/23.
//

import Fluent


struct CreatePayloadsTable: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("payloads")
            .id()
            .field("callback", .string, .required)
            .field("content", .string, .required)
            .field("created_at", .datetime)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("payloads").delete()
    }
    
}
