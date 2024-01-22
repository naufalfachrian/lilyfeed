//
//  CreateYouTubeVideosTable.swift
//  
//
//  Created by Bunga Mungil on 21/06/23.
//

import Fluent


public struct CreateYouTubeVideosTable: AsyncMigration {
    
    public func prepare(on database: Database) async throws {
        try await database.schema("youtube_videos")
            .id()
            .field("subscription_id", .uuid, .references("subscriptions", "id"))
            .field("channel_id", .string, .required)
            .field("channel_name", .string, .required)
            .field("channel_url", .string, .required)
            .field("video_id", .string, .required)
            .field("video_title", .string, .required)
            .field("video_url", .string, .required)
            .field("published_at", .datetime, .required)
            .field("created_at", .datetime, .required)
            .create()
    }
    
    public func revert(on database: Database) async throws {
        try await database.schema("youtube_videos").delete()
    }
    
    public init() { }
    
}
