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
        let response = try await self.client(context.application.client, fetchYouTubeVideoByIDs: payload)
        guard var responseBody = response.body, let data = responseBody.readData(length: responseBody.readableBytes) else {
            context.logger.error("Failed to read bytes on when fetching YouTube Videos Detail")
            return
        }
        guard let responseString = String(data: data, encoding: .utf8) else {
            context.logger.error("Failed to read response string on when fetching YouTube Videos Detail")
            return
        }
        context.logger.info("\(responseString)")
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
