//
//  YouTubeChannel.swift
//
//
//  Created by Bunga Mungil on 01/02/24.
//

import Foundation


protocol YouTubeChannel: Codable {
    
    var eTag: String { get }
    
    var id: String { get }
    
    var snippet: YouTubeChannelSnippet? { get }
    
    var contentDetails: YouTubeChannelContentDetails? { get }
    
    var statistics: YouTubeChannelStatistics? { get }
    
    var topicDetails: YouTubeChannelTopicDetails? { get }
    
    var status: YouTubeChannelStatus? { get }
    
    var brandingSettings: YouTubeChannelBrandingSettings? { get }
    
    var auditDetails: YouTubeChannelAuditDetails? { get }
    
    var contentOwnerDetails: YouTubeChannelContentOwnerDetails? { get }
        
}


// MARK: - YouTube Channel Snippet

protocol YouTubeChannelSnippet: Codable {
    
    var title: String { get }
    
    var description: String { get }
    
    var customURL: String { get }
    
    var publishedAt: Date { get }
    
    var thumbnails: YouTubeChannelSnippetThumbnails? { get }
    
    var defaultLanguage: String { get }
    
    var localized: YouTubeChannelSnippetLocalized? { get }
    
    var country: String { get }
    
}



protocol YouTubeChannelSnippetThumbnails: Codable {
    
    var `default`: YouTubeChannelSnippetThumbnail? { get }
    
    var medium: YouTubeChannelSnippetThumbnail? { get }
    
    var high: YouTubeChannelSnippetThumbnail? { get }
    
}


protocol YouTubeChannelSnippetThumbnail: Codable {
    
    var URL: String { get }
    
    var width: UInt { get }
    
    var height: UInt { get }
    
}


protocol YouTubeChannelSnippetLocalized: Codable {
    
    var title: String { get }
    
    var description: String { get }
    
}


// MARK: - YouTube Channel Content Details

protocol YouTubeChannelContentDetails: Codable {
    
    var relatedPlaylists: YouTubeChannelRelatedPlaylists? { get }
    
}


protocol YouTubeChannelRelatedPlaylists: Codable {
    
    var likes: String { get }
    
    var favorites: String { get }
    
    var uploads: String { get }
    
}


// MARK: - YouTube Channel Statistics

protocol YouTubeChannelStatistics: Codable {
    
    var viewCount: UInt32 { get }
    
    var subscriberCount: UInt32 { get }
    
    var hiddenSubscriberCount: Bool { get }
    
    var videoCount: UInt32 { get }
    
}


// MARK: - YouTube Channel Topic Details

protocol YouTubeChannelTopicDetails: Codable {
    
    var topicIDs: [String] { get }
    
    var topicCategories: [String] { get }
    
}


// MARK: - YouTube Channel Status

protocol YouTubeChannelStatus: Codable {
    
    var privacyStatus: String { get }
    
    var isLinked: Bool { get }
    
    var longUploadStatus: String { get }
    
    var madeForKids: Bool { get }
    
    var selfDeclareMadeForKids: Bool { get }
    
}


// MARK: - YouTube Channel Branding Settings

protocol YouTubeChannelBrandingSettings: Codable {
    
    var channel: YouTubeChannelBrandingSettingsChannel? { get }
    
    var watch: YouTubeChannelBrandingSettingsWatch? { get }
    
}


protocol YouTubeChannelBrandingSettingsChannel: Codable {
    
    var title: String { get }
    
    var description: String { get }
    
    var keywords: String { get }
    
    var trackingAnalyticsAccountID: String { get }
    
    var moderateComments: String { get }
    
    var unsubscribedTrailer: String { get }
    
    var defaultLanguage: String { get }
    
    var country: String { get }
    
}


protocol YouTubeChannelBrandingSettingsWatch: Codable {
    
    var textColor: String { get }
    
    var backgroundColor: String { get }
    
    var featuredPlaylistID: String { get }
    
}


// MARK: - YouTube Channel Audit Details

protocol YouTubeChannelAuditDetails: Codable {
    
    var overallGoodStanding: Bool { get }
    
    var communityGuidelinesGoodStanding: Bool { get }
    
    var copyrightStrikeGoodStanding: Bool { get }
    
    var contentIDClaimsGoodStanding: Bool { get }
    
}


// MARK: - YouTube Channel Content Owner Details

protocol YouTubeChannelContentOwnerDetails: Codable {
    
    var contentOwner: String { get }
    
    var timeLinked: Date { get }
    
}
