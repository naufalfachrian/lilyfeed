//
//  ReceiveYoutubeVideoJob.swift
//
//
//  Created by Bunga Mungil on 21/01/24.
//

import Foundation
import Vapor
import Queues


public struct YoutubeVideoPayload: Codable {
    
    let channelID: String
    
    let channelName: String
    
    let channelURL: String
    
    let videoID: String
    
    let videoTitle: String
    
    let videoURL: String
    
    let publishedAt: Date
    
    init(from youtubeVideo: YoutubeVideo) {
        self.channelID = youtubeVideo.channelID
        self.channelName = youtubeVideo.channelName
        self.channelURL = youtubeVideo.channelURL
        self.videoID = youtubeVideo.videoID
        self.videoTitle = youtubeVideo.videoTitle
        self.videoURL = youtubeVideo.videoURL
        self.publishedAt = youtubeVideo.publishedAt
    }
    
}


public struct ReceiveYoutubeVideoJob: AsyncJob {
    
    public init() {
    }
    
    public typealias Payload = YoutubeVideoPayload
    
    public func dequeue(_ context: QueueContext, _ payload: Payload) async throws {
        context.logger.info("Dequeue Youtube video ID: \(payload.videoID)")
    }
    
    public func error(_ context: QueueContext, _ error: Error, _ payload: Payload) async throws {
        context.logger.error("Error on job ReceiveYoutubeVideoJob: \(payload.videoID) -> \(error.localizedDescription)")
    }
    
}
