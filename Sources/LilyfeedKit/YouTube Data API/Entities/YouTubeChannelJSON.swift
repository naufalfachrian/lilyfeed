//
//  YouTubeChannelJSON.swift
//
//
//  Created by Bunga Mungil on 01/02/24.
//

import Foundation


struct YouTubeChannelJSON: Codable {
    
    private var _eTag: String
    private var _id: String
    private var _snippet: YouTubeChannelSnippetJSON?
    private var _contentDetails: YouTubeChannelContentDetailsJSON?
    private var _statistics: YouTubeChannelStatisticsJSON?
    private var _topicDetails: YouTubeChannelTopicDetailsJSON?
    private var _status: YouTubeChannelStatusJSON?
    private var _brandingSettings: YouTubeChannelBrandingSettingsJSON?
    private var _auditDetails: YouTubeChannelAuditDetailsJSON?
    private var _contentOwnerDetails: YouTubeChannelContentOwnerDetailsJSON?
    
    enum CodingKeys: String, CodingKey {
        case _eTag = "eTag"
        case _id = "id"
        case _snippet = "snippet"
        case _contentDetails = "contentDetails"
        case _statistics = "statistics"
        case _topicDetails = "topicDetails"
        case _status = "status"
        case _brandingSettings = "brandingSettings"
        case _auditDetails = "auditDetails"
        case _contentOwnerDetails = "contentOwnerDetails"
    }
    
}

extension YouTubeChannelJSON: YouTubeChannel {
    
    var eTag: String { return _eTag }
    
    var id: String { return _id }
    
    var snippet: YouTubeChannelSnippet? { return _snippet }
    
    var contentDetails: YouTubeChannelContentDetails? { return _contentDetails }
    
    var statistics: YouTubeChannelStatistics? { return _statistics }
    
    var topicDetails: YouTubeChannelTopicDetails? { return _topicDetails }
    
    var status: YouTubeChannelStatus? { return _status }
    
    var brandingSettings: YouTubeChannelBrandingSettings? { return _brandingSettings }
    
    var auditDetails: YouTubeChannelAuditDetails? { return _auditDetails }
    
    var contentOwnerDetails: YouTubeChannelContentOwnerDetails? { return _contentOwnerDetails }
    
}


// MARK: - YouTube Channel Snippet JSON

struct YouTubeChannelSnippetJSON: Codable {
    
    private var _title: String
    private var _description: String
    private var _customURL: String
    private var _publishedAt: Date
    private var _thumbnails: YouTubeChannelSnippetThumbnailsJSON?
    private var _defaultLanguage: String
    private var _localized: YouTubeChannelSnippetLocalizedJSON?
    private var _country: String
    
    enum CodingKeys: String, CodingKey {
        case _title = "title"
        case _description = "description"
        case _customURL = "customURL"
        case _publishedAt = "publishedAt"
        case _thumbnails = "thumbnails"
        case _defaultLanguage = "defaultLanguage"
        case _localized = "localized"
        case _country = "country"
    }
    
}

extension YouTubeChannelSnippetJSON: YouTubeChannelSnippet {
    
    var title: String { return _title }
    
    var description: String { return _description }
    
    var customURL: String { return _customURL }
    
    var publishedAt: Date { return _publishedAt }
    
    var thumbnails: YouTubeChannelSnippetThumbnails? { return _thumbnails }
    
    var defaultLanguage: String { return _defaultLanguage }
    
    var localized: YouTubeChannelSnippetLocalized? { return _localized }
    
    var country: String { return _country }
    
}

struct YouTubeChannelSnippetThumbnailsJSON: Codable {
    
    private var _default: YouTubeChannelSnippetThumbnailJSON?
    private var _medium: YouTubeChannelSnippetThumbnailJSON?
    private var _high: YouTubeChannelSnippetThumbnailJSON?
    
    enum CodingKeys: String, CodingKey {
        case _default = "default"
        case _medium = "medium"
        case _high = "high"
    }
    
}

extension YouTubeChannelSnippetThumbnailsJSON: YouTubeChannelSnippetThumbnails {
    
    var `default`: YouTubeChannelSnippetThumbnail? { return _default }
    
    var medium: YouTubeChannelSnippetThumbnail? { return _medium }
    
    var high: YouTubeChannelSnippetThumbnail? { return _high }
    
}

struct YouTubeChannelSnippetThumbnailJSON: Codable {
    
    private var _URL: String
    private var _width: UInt
    private var _height: UInt
    
    enum CodingKeys: String, CodingKey {
        case _URL = "URL"
        case _width = "width"
        case _height = "height"
    }
    
}

extension YouTubeChannelSnippetThumbnailJSON: YouTubeChannelSnippetThumbnail {
    
    var URL: String { return _URL }
    
    var width: UInt { return _width }
    
    var height: UInt { return _height }
    
}

struct YouTubeChannelSnippetLocalizedJSON: Codable {
    
    private var _title: String
    private var _description: String
    
    enum CodingKeys: String, CodingKey {
        case _title = "title"
        case _description = "description"
    }
    
}

extension YouTubeChannelSnippetLocalizedJSON: YouTubeChannelSnippetLocalized {
    
    var title: String { return _title }
    
    var description: String { return _description }
    
}



// MARK: - YouTube Channel Content Details JSON

struct YouTubeChannelContentDetailsJSON: Codable {
    
    private var _relatedPlaylists: YouTubeChannelRelatedPlaylistsJSON?
    
    enum CodingKeys: String, CodingKey {
        case _relatedPlaylists = "relatedPlaylists"
    }
    
}

extension YouTubeChannelContentDetailsJSON: YouTubeChannelContentDetails {
    
    var relatedPlaylists: YouTubeChannelRelatedPlaylists? { return _relatedPlaylists }
    
}


struct YouTubeChannelRelatedPlaylistsJSON: Codable {
    
    private var _likes: String
    private var _favorites: String
    private var _uploads: String
    
    enum CodingKeys: String, CodingKey {
        case _likes = "likes"
        case _favorites = "favorites"
        case _uploads = "uploads"
    }
    
}

extension YouTubeChannelRelatedPlaylistsJSON: YouTubeChannelRelatedPlaylists {
    
    var likes: String { return _likes }
    
    var favorites: String { return _favorites }
    
    var uploads: String { return _uploads }
    
}


// MARK: - YouTube Channel Statistics JSON

struct YouTubeChannelStatisticsJSON: Codable {
    
    private var _viewCount: UInt32
    private var _subscriberCount: UInt32
    private var _hiddenSubscriberCount: Bool
    private var _videoCount: UInt32
    
    enum CodingKeys: String, CodingKey {
        case _viewCount = "viewCount"
        case _subscriberCount = "subscriberCount"
        case _hiddenSubscriberCount = "hiddenSubscriberCount"
        case _videoCount = "videoCount"
    }
    
}

extension YouTubeChannelStatisticsJSON: YouTubeChannelStatistics {
    
    var viewCount: UInt32 { return _viewCount }
    
    var subscriberCount: UInt32 { return _subscriberCount }
    
    var hiddenSubscriberCount: Bool { return _hiddenSubscriberCount }
    
    var videoCount: UInt32 { return _videoCount }
    
}


// MARK: - YouTube Channel Topic Details JSON

struct YouTubeChannelTopicDetailsJSON: Codable {
    
    private var _topicIDs: [String]
    private var _topicCategories: [String]
    
    enum CodingKeys: String, CodingKey {
        case _topicIDs = "topicIDs"
        case _topicCategories = "topicCategories"
    }
    
}

extension YouTubeChannelTopicDetailsJSON: YouTubeChannelTopicDetails {
    
    var topicIDs: [String] { return _topicIDs }
    
    var topicCategories: [String] { return _topicCategories }
    
}


// MARK: - YouTube Channel Status JSON

struct YouTubeChannelStatusJSON: Codable {
    
    private var _privacyStatus: String
    private var _isLinked: Bool
    private var _longUploadStatus: String
    private var _madeForKids: Bool
    private var _selfDeclareMadeForKids: Bool
    
    enum CodingKeys: String, CodingKey {
        case _privacyStatus = "privacyStatus"
        case _isLinked = "isLinked"
        case _longUploadStatus = "longUploadStatus"
        case _madeForKids = "madeForKids"
        case _selfDeclareMadeForKids = "selfDeclareMadeForKids"
    }
    
}

extension YouTubeChannelStatusJSON: YouTubeChannelStatus {
    
    var privacyStatus: String { return _privacyStatus }
    
    var isLinked: Bool { return _isLinked }
    
    var longUploadStatus: String { return _longUploadStatus }
    
    var madeForKids: Bool { return _madeForKids }
    
    var selfDeclareMadeForKids: Bool { return _selfDeclareMadeForKids }
    
}


// MARK: - YouTube Channel Branding Settings JSON

struct YouTubeChannelBrandingSettingsJSON: Codable {
    
    private var _channel: YouTubeChannelBrandingSettingsChannelJSON?
    private var _watch: YouTubeChannelBrandingSettingsWatchJSON?
    
    enum CodingKeys: String, CodingKey {
        case _channel = "channel"
        case _watch = "watch"
    }
    
}

extension YouTubeChannelBrandingSettingsJSON: YouTubeChannelBrandingSettings {
    
    var channel: YouTubeChannelBrandingSettingsChannel? { return _channel }
    
    var watch: YouTubeChannelBrandingSettingsWatch? { return _watch }
    
}

struct YouTubeChannelBrandingSettingsChannelJSON: Codable {
    
    private var _title: String
    private var _description: String
    private var _keywords: String
    private var _trackingAnalyticsAccountID: String
    private var _moderateComments: String
    private var _unsubscribedTrailer: String
    private var _defaultLanguage: String
    private var _country: String
    
    enum CodingKeys: String, CodingKey {
        case _title = "title"
        case _description = "description"
        case _keywords = "keywords"
        case _trackingAnalyticsAccountID = "trackingAnalyticsAccountID"
        case _moderateComments = "moderateComments"
        case _unsubscribedTrailer = "unsubscribedTrailer"
        case _defaultLanguage = "defaultLanguage"
        case _country = "country"
    }
    
}

extension YouTubeChannelBrandingSettingsChannelJSON: YouTubeChannelBrandingSettingsChannel {
    
    var title: String { return _title }
    
    var description: String { return _description }
    
    var keywords: String { return _keywords }
    
    var trackingAnalyticsAccountID: String { return _trackingAnalyticsAccountID }
    
    var moderateComments: String { return _moderateComments }
    
    var unsubscribedTrailer: String { return _unsubscribedTrailer }
    
    var defaultLanguage: String { return _defaultLanguage }
    
    var country: String { return _country }
    
}

struct YouTubeChannelBrandingSettingsWatchJSON: Codable {
    
    private var _textColor: String
    private var _backgroundColor: String
    private var _featuredPlaylistID: String
    
    enum CodingKeys: String, CodingKey {
        case _textColor = "textColor"
        case _backgroundColor = "backgroundColor"
        case _featuredPlaylistID = "featuredPlaylistID"
    }
    
}

extension YouTubeChannelBrandingSettingsWatchJSON: YouTubeChannelBrandingSettingsWatch {
    
    var textColor: String { return _textColor }
    
    var backgroundColor: String { return _backgroundColor }
    
    var featuredPlaylistID: String { return _featuredPlaylistID }
    
}


// MARK: - YouTube Channel Audit Details JSON

struct YouTubeChannelAuditDetailsJSON: Codable {
    
    private var _overallGoodStanding: Bool
    private var _communityGuidelinesGoodStanding: Bool
    private var _copyrightStrikeGoodStanding: Bool
    private var _contentIDClaimsGoodStanding: Bool
    
    enum CodingKeys: String, CodingKey {
        case _overallGoodStanding = "overallGoodStanding"
        case _communityGuidelinesGoodStanding = "communityGuidelinesGoodStanding"
        case _copyrightStrikeGoodStanding = "copyrightStrikeGoodStanding"
        case _contentIDClaimsGoodStanding = "contentIDClaimsGoodStanding"
    }
    
}

extension YouTubeChannelAuditDetailsJSON: YouTubeChannelAuditDetails {
    
    var overallGoodStanding: Bool { return _overallGoodStanding }
    
    var communityGuidelinesGoodStanding: Bool { return _communityGuidelinesGoodStanding }
    
    var copyrightStrikeGoodStanding: Bool { return _copyrightStrikeGoodStanding }
    
    var contentIDClaimsGoodStanding: Bool { return _contentIDClaimsGoodStanding }
    
}


// MARK: - YouTube Channel Content Owner Details JSON

struct YouTubeChannelContentOwnerDetailsJSON: Codable {
    
    private var _contentOwner: String
    private var _timeLinked: Date
    
    enum CodingKeys: String, CodingKey {
        case _contentOwner = "contentOwner"
        case _timeLinked = "timeLinked"
    }
    
}

extension YouTubeChannelContentOwnerDetailsJSON: YouTubeChannelContentOwnerDetails {
    
    var contentOwner: String { return _contentOwner }
    
    var timeLinked: Date { return _timeLinked }
    
}
