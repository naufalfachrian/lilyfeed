//
//  FetchingYouTubeVideosDetailJob.swift
//
//
//  Created by Bunga Mungil on 30/01/24.
//

import Foundation
import Vapor
import Queues


public struct FetchingYouTubeVideosDetailJob: AsyncJob {
    
    public init() {
    }
    
    public typealias Payload = [YouTubeVideoID]
    
    public func dequeue(_ context: QueueContext, _ payload: [YouTubeVideoID]) async throws {
        if payload.isEmpty { return }
        let response = try await self.client(context.application.client, fetchYouTubeVideoByIDs: payload)
        response.items.forEach { item in
            context.logger.info("Received additional information for Video ID : \(item.id)")
            if
                let liveStreamingDetails = item.liveStreamingDetails,
                let scheduledStartTime = liveStreamingDetails.scheduledStartTime 
            {
                context.logger.info("Livestream scheduled on \(DateFormatter.display.string(from: scheduledStartTime))")
            } else {
                context.logger.info("Video length \(item.contentDetails.duration) seconds")
            }
        }
    }
    
}


extension FetchingYouTubeVideosDetailJob: FetchYouTubeVideoByIDs {
    
}
