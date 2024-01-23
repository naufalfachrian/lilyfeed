//
//  StoringYouTubeVideosJob.swift
//
//
//  Created by Bunga Mungil on 22/01/24.
//

import Foundation
import Vapor
import Queues


public struct StoringYouTubeVideosJob: AsyncJob {
    
    public init() {
    }
    
    public typealias Payload = [YouTubeVideoModel]
    
    public func dequeue(_ context: Queues.QueueContext, _ payload: [YouTubeVideoModel]) async throws {
        context.logger.info("Storing YouTube Videos to storage -> \(payload.map { item in item.videoID }.joined(by: ", "))")
        for youTubeVideo in payload {
            try await youTubeVideo.save(on: context.application.db)
        }
    }
    
}
