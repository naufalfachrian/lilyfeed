//
//  YoutubeVideo.swift
//  
//
//  Created by Bunga Mungil on 21/06/23.
//

import Fluent
import Foundation
import WebSubSubscriber


protocol YoutubeVideo {
    
    var fromSubscription: Subscription? { get }
    
    var channelID: String { get }
    
    var channelName: String { get }
    
    var channelURL: String { get }
    
    var videoID: String { get }
    
    var videoTitle: String { get }
    
    var videoURL: String { get }
    
    var publishedAt: Date { get }
    
}


extension Sequence where Element == any YoutubeVideo & Model {
    
    func ids(separator: String) -> String {
        self.map { item in item.channelID }.joined(separator: separator)
    }
    
}
