//
//  ReceivingYouTubeVideosJob.swift
//
//
//  Created by Bunga Mungil on 22/01/24.
//

import Foundation
import Vapor
import Queues


public struct ReceivingYouTubeVideosJob: AsyncJob {
    
    public init() {
    }
    
    public typealias Payload = [YouTubeVideoModel]
    
    public func dequeue(_ context: Queues.QueueContext, _ payload: [YouTubeVideoModel]) async throws {
        payload.forEach { youTubeVideo in
            context.logger.info("Received YouTube Video -> \(youTubeVideo.videoURL)")
        }
    }
    
}
