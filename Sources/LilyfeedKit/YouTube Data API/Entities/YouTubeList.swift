//
//  YouTubeList.swift
//
//
//  Created by Bunga Mungil on 31/01/24.
//

import Foundation


class YouTubeList<Items: Codable>: Codable {
    
    var eTag: String
    
    var items: [Items]
    
    var pageInfo: YouTubePageInfo
    
    enum CodingKeys: String, CodingKey {
        case eTag = "etag"
        case items = "items"
        case pageInfo = "pageInfo"
    }
    
}


// MARK: - YouTube Video List

class YouTubeVideoListJSON: YouTubeList<YouTubeVideoDetail> {
    
}


// MARK: - YouTube Channel List

class YouTubeChannelListJSON: YouTubeList<YouTubeChannel> {
    
}
