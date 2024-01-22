//
//  ReceivingDeletedYouTubeVideos.swift
//
//
//  Created by Bunga Mungil on 22/01/24.
//

import Foundation
import Vapor
import Queues


public struct ReceivingDeletedYouTubeVideos: AsyncJob {
    
    public init() {
    }
    
    public typealias Payload = [String]
    
    public func dequeue(_ context: QueueContext, _ payload: [String]) async throws {
        payload.forEach { videoID in
            context.logger.info("Received Deleted YouTube Video -> \(videoID)")
        }
    }
    
}
