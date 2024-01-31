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
        let items = try response.content.decode(YouTubeVideoListJSON.self).items
        items.forEach { item in
            context.logger.info("Received additional information for Video ID : \(item.id)")
            if let liveStreamingDetails = item.liveStreamingDetails {
                context.logger.info("Livestream scheduled on \(liveStreamingDetails.scheduledStartTime?.ISO8601Format() ?? "N/A")")
            } else {
                context.logger.info("Video length \(item.contentDetails.duration) seconds")
            }
        }
    }
    
    fileprivate func client(_ client: Client, fetchYouTubeVideoByIDs videoIDs: [YouTubeVideoID]) async throws -> ClientResponse {
        var headers = HTTPHeaders()
        headers.add(name: HTTPHeaders.Name.accept, value: "application/json")
        return try await client.get(URI(string: "https://youtube.googleapis.com/youtube/v3/videos"), headers: headers) { request in
            try request.query.encode(FetchYouTubeVideoByIDsQuery(
                part: [
                    "id",
                    "snippet",
                    "contentDetails",
                    "status",
                    "statistics",
                    "liveStreamingDetails",
                ],
                id: videoIDs,
                key: Environment.get("YOUTUBE_API_KEY")!
            ), using: URLEncodedFormEncoder(configuration: .init(arrayEncoding: .values)))
        }
    }
    
}


public typealias YouTubeVideoID = String


private struct FetchYouTubeVideoByIDsQuery: Codable {
    
    let part: [String]
    
    let id: [String]
    
    let key: String
    
}
