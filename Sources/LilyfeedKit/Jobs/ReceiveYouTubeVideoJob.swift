//
//  ReceiveYouTubeVideoJob.swift
//
//
//  Created by Bunga Mungil on 21/01/24.
//

import Foundation
import Vapor
import Queues


public struct YouTubeVideoPayload: Codable {
    
    let channelID: String
    
    let channelName: String
    
    let channelURL: String
    
    let videoID: String
    
    let videoTitle: String
    
    let videoURL: String
    
    let publishedAt: Date
    
    init(from youTubeVideo: YouTubeVideo) {
        self.channelID = youTubeVideo.channelID
        self.channelName = youTubeVideo.channelName
        self.channelURL = youTubeVideo.channelURL
        self.videoID = youTubeVideo.videoID
        self.videoTitle = youTubeVideo.videoTitle
        self.videoURL = youTubeVideo.videoURL
        self.publishedAt = youTubeVideo.publishedAt
    }
    
}


public struct ReceiveYouTubeVideoJob: AsyncJob {
    
    public init() {
    }
    
    public typealias Payload = YouTubeVideoPayload
    
    public func dequeue(_ context: QueueContext, _ payload: Payload) async throws {
        context.logger.info("Dequeue YouTube video ID: \(payload.videoID)")
    }
    
    public func error(_ context: QueueContext, _ error: Error, _ payload: Payload) async throws {
        context.logger.error("Error on job ReceiveYouTubeVideoJob: \(payload.videoID) -> \(error.localizedDescription)")
    }
    
}
