//
//  YouTubeList.swift
//
//
//  Created by Bunga Mungil on 02/02/24.
//

import Foundation


protocol YouTubeList {
    
    associatedtype Items
    
    var eTag: String { get }
    
    var items: [Items] { get }
    
    var pageInfo: YouTubePageInfo { get }
    
}


protocol YouTubeVideoList: YouTubeList where Items == YouTubeVideoDetail { }


protocol YouTubeChannelList: YouTubeList where Items == YouTubeChannel { }
