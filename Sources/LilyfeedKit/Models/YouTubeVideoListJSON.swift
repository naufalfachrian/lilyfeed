//
//  YouTubeVideoListJSON.swift
//
//
//  Created by Bunga Mungil on 31/01/24.
//

import Foundation


struct YouTubeVideoListJSON: Codable {
    
    private var _eTag: String
    
    private var _items: [YouTubeVideoDetailJSON]
    
    private var _pageInfo: YouTubePageInfoJSON
    
    enum CodingKeys: String, CodingKey {
        case _eTag = "etag"
        case _items = "items"
        case _pageInfo = "pageInfo"
    }
    
}

extension YouTubeVideoListJSON: YouTubeVideoList {
    
    var eTag: String { return _eTag }
    
    var items: [YouTubeVideoDetail] { return _items }
    
    var pageInfo: YouTubePageInfo { return _pageInfo }
    
}


// MARK: - YouTube Page Info

struct YouTubePageInfoJSON: Codable {
    
    private var _totalResult: UInt
    
    private var _resultsPerPage: UInt
    
    enum CodingKeys: String, CodingKey {
        case _totalResult = "totalResults"
        case _resultsPerPage = "resultsPerPage"
    }
    
}


extension YouTubePageInfoJSON: YouTubePageInfo {
    
    var totalResult: UInt { return _totalResult }
    
    var resultPerPage: UInt { return _resultsPerPage }
    
}
