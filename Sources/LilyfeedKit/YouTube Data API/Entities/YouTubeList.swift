//
//  YouTubeListJSON.swift
//
//
//  Created by Bunga Mungil on 31/01/24.
//

import Foundation


class YouTubeListJSON<Items: Codable>: Codable {
    
    var eTag: String
    
    var items: [Items]
    
    var pageInfo: YouTubePageInfoJSON
    
    enum CodingKeys: String, CodingKey {
        case eTag = "etag"
        case items = "items"
        case pageInfo = "pageInfo"
    }
    
}


// MARK: - YouTube Video List JSON

class YouTubeVideoListJSON: YouTubeListJSON<YouTubeVideoDetailJSON> {
    
}


// MARK: - YouTube Channel List JSON

class YouTubeChannelListJSON: YouTubeListJSON<YouTubeChannelJSON> {
    
}
