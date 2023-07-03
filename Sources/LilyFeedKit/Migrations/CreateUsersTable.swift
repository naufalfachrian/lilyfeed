//
//  CreateUsersTable.swift
//  
//
//  Created by Bunga Mungil on 21/06/23.
//

import Fluent


public struct CreateUsersTable: AsyncMigration {
    
    public func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required)
            .field("password", .string, .required)
            .unique(on: "username")
            .create()
    }
    
    public func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
    
    public init() { }
    
}
