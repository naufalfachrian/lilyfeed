//
//  ReceivingDeletedYouTubeVideos.swift
//
//
//  Created by Bunga Mungil on 22/01/24.
//

import Foundation
import Vapor
import Queues
import FluentKit


public struct DeletingYouTubeVideosJob: AsyncJob {
    
    public init() {
    }
    
    public typealias Payload = [String]
    
    public func dequeue(_ context: QueueContext, _ payload: [String]) async throws {
        context.logger.info("Deleting YouTube Videos from storage -> \(payload.joined(separator: ", "))")
        try await YouTubeVideoModel
            .query(on: context.application.db)
            .filter(\.$videoID ~~ payload)
            .delete()
    }
    
}
