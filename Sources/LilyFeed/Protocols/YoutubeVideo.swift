//
//  YoutubeVideo.swift
//  
//
//  Created by Bunga Mungil on 21/06/23.
//

import Foundation
import WebSubSubscriber


protocol YoutubeVideo {
    
    var fromSubscription: Subscription? { get }
    
    var channelID: String { get }
    
    var channelName: String { get }
    
    var channelURL: URL { get }
    
    var videoID: String { get }
    
    var videoTitle: String { get }
    
    var videoURL: URL { get }
    
    var publishedAt: Date { get }
    
}
