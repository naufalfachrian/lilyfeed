//
//  YouTubeVideoList.swift
//
//
//  Created by Bunga Mungil on 31/01/24.
//

import Foundation


protocol YouTubeVideoList {
    
    var eTag: String { get }
    
    var items: [YouTubeVideoDetail] { get }
    
    var pageInfo: YouTubePageInfo { get }
    
}


// MARK: - YouTube Page Info

protocol YouTubePageInfo {
    
    var totalResult: UInt { get }
    
    var resultPerPage: UInt { get }
    
}
