//
//  FetchYouTubeChannelByIDs.swift
//
//
//  Created by Bunga Mungil on 02/02/24.
//

import Foundation
import Vapor


protocol FetchYouTubeChannelByIDs {
    
    func client(_ client: Client, fetchYouTubeChannelByIDs channelIDs: [YouTubeChannelID]) async throws -> any YouTubeChannelList
    
}


extension FetchYouTubeChannelByIDs {
    
    func client(_ client: Client, fetchYouTubeChannelByIDs channelIDs: [YouTubeChannelID]) async throws -> any YouTubeChannelList {
        var headers = HTTPHeaders()
        headers.add(name: HTTPHeaders.Name.accept, value: "application/json")
        let response = try await client.get(URI(string: "https://youtube.googleapis.com/youtube/v3/videos"), headers: headers) { request in
            try request.query.encode(FetchYouTubeChannelByIDsQuery(
                part: [
                    "id",
                    "snippet",
                    "contentDetails",
                    "status",
                    "statistics",
                ],
                id: channelIDs,
                key: Environment.get("YOUTUBE_API_KEY")!
            ), using: URLEncodedFormEncoder(configuration: .init(arrayEncoding: .values)))
        }
        return try response.content.decode(YouTubeChannelListJSON.self)
    }
    
}


typealias YouTubeChannelID = String


private struct FetchYouTubeChannelByIDsQuery: Codable {
    
    let part: [String]
    
    let id: [YouTubeChannelID]
    
    let key: String
    
}
