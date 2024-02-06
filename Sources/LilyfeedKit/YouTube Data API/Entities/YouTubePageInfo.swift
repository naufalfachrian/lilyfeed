//
//  YouTubePageInfoJSON.swift
//
//
//  Created by Bunga Mungil on 01/02/24.
//

import Foundation


struct YouTubePageInfoJSON: Codable {
    
    var totalResult: UInt
    
    var resultsPerPage: UInt
    
    enum CodingKeys: String, CodingKey {
        case totalResult = "totalResults"
        case resultsPerPage = "resultsPerPage"
    }
    
}
