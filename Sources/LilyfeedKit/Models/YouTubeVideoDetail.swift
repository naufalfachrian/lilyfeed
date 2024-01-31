//
//  YouTubeVideoDetail.swift
//
//
//  Created by Bunga Mungil on 31/01/24.
//

import Foundation


protocol YouTubeVideoDetail {
    
    var eTag: String { get }
    
    var id: String { get }
    
    var snippet: YouTubeVideoSnippet { get }
    
    var contentDetails: YouTubeVideoContentDetails { get }
    
    var status: YouTubeVideoStatus { get }
    
    var statistics: YouTubeVideoStatistics { get }
    
    var liveStreamingDetails: YouTubeVideoLiveStreamingDetails? { get }
    
}


protocol YouTubeVideoSnippet {
    
    var publishedAt: Date? { get }
    
    var channelID: String { get }
    
    var title: String { get }
    
    var description: String { get }
    
    var thumbnails: YouTubeVideoThumbnails? { get }
    
    var channelTitle: String { get }
    
    var categoryID: String { get }
    
    var liveBroadcastContent: LiveBroadcastContent { get }
    
}

enum LiveBroadcastContent {
    case none
    case live
    case upcoming
}


protocol YouTubeVideoThumbnails {
    
    var `default`: YouTubeVideoThumbnail? { get }
    
    var medium: YouTubeVideoThumbnail? { get }
    
    var high: YouTubeVideoThumbnail? { get }
    
}


protocol YouTubeVideoThumbnail {
    
    var url: String { get }
    
    var width: UInt { get }
    
    var height: UInt { get }
    
}


protocol YouTubeVideoContentDetails {
    
    var duration: UInt { get }
    
    var dimension: YouTubeVideContentDimension { get }
    
    var definition: YouTubeVideoContentDefinition { get }
    
    var caption: Bool { get }
    
    var licensedContent: Bool { get }
    
    var projection: YouTubeVideoContentProjection { get }
    
}


enum YouTubeVideContentDimension {
    case d2d
    case d3d
    case undefined(_ raw: String)
}


enum YouTubeVideoContentDefinition {
    case hd
    case sd
    case undefined(_ raw: String)
}


enum YouTubeVideoContentProjection {
    case p360
    case rectangular
    case undefined(_ raw: String)
}


protocol YouTubeVideoStatus {
    
    var uploadStatus: YouTubeVideoUploadStatus? { get }
    
    var privacyStatus: YouTubeVideoPrivacyStatus? { get }
    
    var license: YouTubeVideoLicense? { get }
    
    var embeddable: Bool { get }
    
    var publicStatsViewable: Bool { get }
    
    var madeForKids: Bool { get }
    
}


enum YouTubeVideoUploadStatus {
    case deleted
    case failed
    case processed
    case rejected
    case uploaded
    case undefined(_ raw: String)
}


enum YouTubeVideoPrivacyStatus {
    case `private`
    case `public`
    case unlisted
    case undefined(_ raw: String)
}


enum YouTubeVideoLicense {
    case creativeCommon
    case youTube
    case undefined(_ raw: String)
}


protocol YouTubeVideoStatistics {
    
    var viewsCount: UInt { get }
    
    var likesCount: UInt { get }
        
    var commentsCount: UInt { get }
    
}


protocol YouTubeVideoLiveStreamingDetails {
    
    var scheduledStartTime: Date? { get }
    
    var activeLiveChatID: String? { get }
    
}
