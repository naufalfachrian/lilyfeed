//
//  YouTubeListJSON.swift
//
//
//  Created by Bunga Mungil on 31/01/24.
//

import Foundation


class YouTubeListJSON<Items: Codable>: Codable {
    
    internal var _eTag: String
    
    internal var _items: [Items]
    
    internal var _pageInfo: YouTubePageInfoJSON
    
    enum CodingKeys: String, CodingKey {
        case _eTag = "etag"
        case _items = "items"
        case _pageInfo = "pageInfo"
    }
    
}


// MARK: - YouTube Video List JSON

class YouTubeVideoListJSON: YouTubeListJSON<YouTubeVideoDetailJSON> {
    
}

extension YouTubeVideoListJSON: YouTubeVideoList {
    
    var eTag: String { return _eTag }
    
    var items: [YouTubeVideoDetail] { return _items }
    
    var pageInfo: YouTubePageInfo { return _pageInfo }
    
}


// MARK: - YouTube Channel List JSON

class YouTubeChannelListJSON: YouTubeListJSON<YouTubeChannelJSON> {
    
}

extension YouTubeChannelListJSON: YouTubeChannelList {
    
    var eTag: String { return _eTag }
    
    var items: [YouTubeChannel] { return _items }
    
    var pageInfo: YouTubePageInfo { return _pageInfo }
    
}
