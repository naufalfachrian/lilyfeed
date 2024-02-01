//
//  YouTubePageInfoJSON.swift
//
//
//  Created by Bunga Mungil on 01/02/24.
//

import Foundation


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
