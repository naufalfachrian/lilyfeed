//
//  YouTubeChannel.swift
//
//
//  Created by Bunga Mungil on 01/02/24.
//

import Foundation


struct YouTubeChannel: Codable {
    
    var eTag: String
    var id: String
    var snippet: YouTubeChannelSnippet?
    var contentDetails: YouTubeChannelContentDetails?
    var statistics: YouTubeChannelStatistics?
    var topicDetails: YouTubeChannelTopicDetails?
    var status: YouTubeChannelStatus?
    var brandingSettings: YouTubeChannelBrandingSettings?
    var auditDetails: YouTubeChannelAuditDetails?
    var contentOwnerDetails: YouTubeChannelContentOwnerDetails?
    
    enum CodingKeys: String, CodingKey {
        case eTag = "etag"
        case id = "id"
        case snippet = "snippet"
        case contentDetails = "contentDetails"
        case statistics = "statistics"
        case topicDetails = "topicDetails"
        case status = "status"
        case brandingSettings = "brandingSettings"
        case auditDetails = "auditDetails"
        case contentOwnerDetails = "contentOwnerDetails"
    }
    
}


// MARK: - YouTube Channel Snippet

struct YouTubeChannelSnippet: Codable {
    
    var title: String
    var description: String
    var customURL: String
    var publishedAt: Date
    var thumbnails: YouTubeChannelSnippetThumbnails?
    var defaultLanguage: String?
    var localized: YouTubeChannelSnippetLocalized?
    var country: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case customURL = "customUrl"
        case publishedAt = "publishedAt"
        case thumbnails = "thumbnails"
        case defaultLanguage = "defaultLanguage"
        case localized = "localized"
        case country = "country"
    }
    
}


struct YouTubeChannelSnippetThumbnails: Codable {
    
    var `default`: YouTubeChannelSnippetThumbnail?
    var medium: YouTubeChannelSnippetThumbnail?
    var high: YouTubeChannelSnippetThumbnail?
    
    enum CodingKeys: String, CodingKey {
        case `default` = "default"
        case medium = "medium"
        case high = "high"
    }
    
}


struct YouTubeChannelSnippetThumbnail: Codable {
    
    var URL: String
    var width: UInt
    var height: UInt
    
    enum CodingKeys: String, CodingKey {
        case URL = "url"
        case width = "width"
        case height = "height"
    }
    
}


struct YouTubeChannelSnippetLocalized: Codable {
    
    var title: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
    }
    
}


// MARK: - YouTube Channel Content Details

struct YouTubeChannelContentDetails: Codable {
    
    var relatedPlaylists: YouTubeChannelRelatedPlaylists?
    
    enum CodingKeys: String, CodingKey {
        case relatedPlaylists = "relatedPlaylists"
    }
    
}


struct YouTubeChannelRelatedPlaylists: Codable {
    
    var likes: String
    var uploads: String
    
    enum CodingKeys: String, CodingKey {
        case likes = "likes"
        case uploads = "uploads"
    }
    
}


// MARK: - YouTube Channel Statistics

struct YouTubeChannelStatistics: Codable {
    
    var viewCount: UInt32
    var subscriberCount: UInt32
    var hiddenSubscriberCount: Bool
    var videoCount: UInt32
    
    enum CodingKeys: String, CodingKey {
        case viewCount = "viewCount"
        case subscriberCount = "subscriberCount"
        case hiddenSubscriberCount = "hiddenSubscriberCount"
        case videoCount = "videoCount"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.viewCount = UInt32(try container.decode(String.self, forKey: .viewCount)) ?? 0
        self.subscriberCount = UInt32(try container.decode(String.self, forKey: .subscriberCount)) ?? 0
        self.hiddenSubscriberCount = try container.decode(Bool.self, forKey: .hiddenSubscriberCount)
        self.videoCount = UInt32(try container.decode(String.self, forKey: .videoCount)) ?? 0
    }
    
}


// MARK: - YouTube Channel Topic Details

struct YouTubeChannelTopicDetails: Codable {
    
    var topicIDs: [String]
    var topicCategories: [String]
    
    enum CodingKeys: String, CodingKey {
        case topicIDs = "topicIds"
        case topicCategories = "topicCategories"
    }
    
}


// MARK: - YouTube Channel Status

struct YouTubeChannelStatus: Codable {
    
    var privacyStatus: String
    var isLinked: Bool
    var longUploadsStatus: String
    var madeForKids: Bool
    var selfDeclareMadeForKids: Bool
    
    enum CodingKeys: String, CodingKey {
        case privacyStatus = "privacyStatus"
        case isLinked = "isLinked"
        case longUploadsStatus = "longUploadsStatus"
        case madeForKids = "madeForKids"
        case selfDeclareMadeForKids = "selfDeclareMadeForKids"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.privacyStatus = try container.decode(String.self, forKey: .privacyStatus)
        self.isLinked = try container.decode(Bool.self, forKey: .isLinked)
        self.longUploadsStatus = try container.decode(String.self, forKey: .longUploadsStatus)
        self.madeForKids = (try? container.decode(Bool.self, forKey: .madeForKids)) ?? false
        self.selfDeclareMadeForKids = (try? container.decode(Bool.self, forKey: .selfDeclareMadeForKids)) ?? false
    }
    
}


// MARK: - YouTube Channel Branding Settings

struct YouTubeChannelBrandingSettings: Codable {
    
    var channel: YouTubeChannelBrandingSettingsChannel?
    var watch: YouTubeChannelBrandingSettingsWatch?
    
    enum CodingKeys: String, CodingKey {
        case channel = "channel"
        case watch = "watch"
    }
    
}


struct YouTubeChannelBrandingSettingsChannel: Codable {
    
    var title: String
    var description: String
    var keywords: String
    var trackingAnalyticsAccountID: String
    var moderateComments: String
    var unsubscribedTrailer: String
    var defaultLanguage: String
    var country: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case keywords = "keywords"
        case trackingAnalyticsAccountID = "trackingAnalyticsAccountId"
        case moderateComments = "moderateComments"
        case unsubscribedTrailer = "unsubscribedTrailer"
        case defaultLanguage = "defaultLanguage"
        case country = "country"
    }
    
}


struct YouTubeChannelBrandingSettingsWatch: Codable {
    
    var textColor: String
    var backgroundColor: String
    var featuredPlaylistID: String
    
    enum CodingKeys: String, CodingKey {
        case textColor = "textColor"
        case backgroundColor = "backgroundColor"
        case featuredPlaylistID = "featuredPlaylistId"
    }
    
}


// MARK: - YouTube Channel Audit Details

struct YouTubeChannelAuditDetails: Codable {
    
    var overallGoodStanding: Bool
    var communityGuidelinesGoodStanding: Bool
    var copyrightStrikeGoodStanding: Bool
    var contentIDClaimsGoodStanding: Bool
    
    enum CodingKeys: String, CodingKey {
        case overallGoodStanding = "overallGoodStanding"
        case communityGuidelinesGoodStanding = "communityGuidelinesGoodStanding"
        case copyrightStrikeGoodStanding = "copyrightStrikeGoodStanding"
        case contentIDClaimsGoodStanding = "contentIdClaimsGoodStanding"
    }
    
}


// MARK: - YouTube Channel Content Owner Details

struct YouTubeChannelContentOwnerDetails: Codable {
    
    var contentOwner: String
    var timeLinked: Date
    
    enum CodingKeys: String, CodingKey {
        case contentOwner = "contentOwner"
        case timeLinked = "timeLinked"
    }
    
}
