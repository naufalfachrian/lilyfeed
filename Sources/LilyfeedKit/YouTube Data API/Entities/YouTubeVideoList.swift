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
