//
//  ReceivingPayloadJob.swift
//
//
//  Created by Bunga Mungil on 22/01/24.
//

import Foundation
import Vapor
import Queues
import WebSubSubscriber
import FeedKit


public struct ReceivedPayload: Codable {
    
    let data: ByteBuffer?
    
    let subscription: SubscriptionModel
    
}


public struct ReceivingPayloadJob: AsyncJob {
    
    public init() {
    }
    
    public typealias Payload = ReceivedPayload
    
    public func dequeue(_ context: QueueContext, _ payload: Payload) async throws {
        context.logger.info("Dequeue payload from subscription : \(payload.subscription.topic)")
        guard var mPayloadData = payload.data, let data = mPayloadData.readData(length: mPayloadData.readableBytes) else {
            context.logger.info("Failed to read bytes on payload data")
            return
        }
        context.logger.trace("\(String(data: data, encoding: .utf8) ?? "N/A")")
        switch data.payloadContent(for: payload.subscription) {
        case .nothing:
            context.logger.info("Payload from subscription : \(payload.subscription.topic) deliver nothing")
        case .youTubeVideos(let youTubeVideos):
            context.logger.info("Payload from subscription : \(payload.subscription.topic) contains \(youTubeVideos.count) entries")
            try await context.queue.dispatch(StoringYouTubeVideosJob.self, youTubeVideos)
            try await context.queue.dispatch(FetchingYouTubeVideosDetailJob.self, .init(youTubeVideos.compactMap { youTubeVideo in youTubeVideo.videoID } ))
        case .deletedYouTubeVideos(let deletedVideoIDs):
            context.logger.info("Payload from subscription : \(payload.subscription.topic) contains \(deletedVideoIDs.count) deleted entries")
            try await context.queue.dispatch(DeletingYouTubeVideosJob.self, .init(deletedVideoIDs))
        case .failure(let reason):
            context.logger.error("Failure when reading content of payload from \(payload.subscription.topic) -> \(reason.localizedDescription)")
        }
    }
    
    public func error(_ context: QueueContext, _ error: Error, _ payload: ReceivedPayload) async throws {
        context.logger.error("Error on job ReceiveYouTubeVideoJob -> \(error.localizedDescription)")
    }
    
}


enum PayloadContent {
    
    case nothing
    
    case youTubeVideos(_ youTubeVideos: [YouTubeVideoModel])
    
    case deletedYouTubeVideos(_ ids: [String])
    
    case failure(_ reason: Error)
    
}


fileprivate extension Data {
    
    func payloadContent(for subscription: SubscriptionModel) -> PayloadContent {
        switch FeedParser(data: self).parse() {
        case .success(let feed):
            let entries = feed.atomFeed?.entries ?? []
            if !entries.isEmpty {
                return .youTubeVideos(
                    entries.flatMap { entry in
                        guard let youTubeVideo = YouTubeVideoModel(entry: entry, with: subscription) else {
                            return [] as [YouTubeVideoModel]
                        }
                        return [youTubeVideo]
                    }
                )
            }
            let deletedEntries = feed.atomFeed?.deletedEntries ?? []
            if !deletedEntries.isEmpty {
                return .deletedYouTubeVideos(
                    deletedEntries.flatMap { entry in
                        guard let entryID = entry.attributes?.ref else {
                            return [] as [String]
                        }
                        return [entryID]
                    }
                )
            }
            return .nothing
        case .failure(let reason):
            return .failure(reason)
        }
    }
    
}
