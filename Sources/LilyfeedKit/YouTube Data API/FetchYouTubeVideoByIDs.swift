//
//  FetchYouTubeVideoByIDs.swift
//
//
//  Created by Bunga Mungil on 01/02/24.
//

import Foundation
import Vapor


protocol FetchYouTubeVideoByIDs {
    
    func client(_ client: Client, fetchYouTubeVideoByIDs videoIDs: [YouTubeVideoID]) async throws -> YouTubeVideoList
    
}


extension FetchYouTubeVideoByIDs {
    
    func client(_ client: Client, fetchYouTubeVideoByIDs videoIDs: [YouTubeVideoID]) async throws -> YouTubeVideoList {
        var headers = HTTPHeaders()
        headers.add(name: HTTPHeaders.Name.accept, value: "application/json")
        let response = try await client.get(URI(string: "https://youtube.googleapis.com/youtube/v3/videos"), headers: headers) { request in
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
        return try response.content.decode(YouTubeVideoListJSON.self)
    }
    
}


public typealias YouTubeVideoID = String


private struct FetchYouTubeVideoByIDsQuery: Codable {
    
    let part: [String]
    
    let id: [String]
    
    let key: String
    
}
