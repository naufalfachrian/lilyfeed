//
//  YouTubeVideoDetailJSON.swift
//
//
//  Created by Bunga Mungil on 31/01/24.
//

import Foundation


struct YouTubeVideoDetailJSON: Codable {
    
    private var _eTag: String
    
    private var _id: String
    
    private var _snippet: YouTubeVideoSnippetJSON
    
    private var _contentDetails: YouTubeVideoContentDetailsJSON
    
    private var _status: YouTubeVideoStatusJSON
    
    private var _statistics: YouTubeVideoStatisticsJSON
    
    private var _liveStreamingDetails: YouTubeVideoLiveStreamingDetailsJSON?
    
    enum CodingKeys: String, CodingKey {
        case _eTag = "etag"
        case _id = "id"
        case _snippet = "snippet"
        case _contentDetails = "contentDetails"
        case _status = "status"
        case _statistics = "statistics"
        case _liveStreamingDetails = "liveStreamingDetails"
    }
    
}

extension YouTubeVideoDetailJSON: YouTubeVideoDetail {
    
    var eTag: String { return _eTag }
    
    var id: String { return _id }
    
    var snippet: YouTubeVideoSnippet { return _snippet }
    
    var contentDetails: YouTubeVideoContentDetails { return _contentDetails }
    
    var status: YouTubeVideoStatus { return _status }
    
    var statistics: YouTubeVideoStatistics { return _statistics }
    
    var liveStreamingDetails: YouTubeVideoLiveStreamingDetails? { return _liveStreamingDetails }
    
}


// MARK: - YouTube Video Snippet JSON

struct YouTubeVideoSnippetJSON: Codable {
    
    private var _publishedAt: String
    
    private var _channelID: String
    
    private var _title: String
    
    private var _description: String
    
    private var _thumbnails: YouTubeVideoThumbnailsJSON?
    
    private var _channelTitle: String
    
    private var _categoryID: String
    
    private var _liveBroadcastContent: String
    
    enum CodingKeys: String, CodingKey {
        case _publishedAt = "publishedAt"
        case _channelID = "channelId"
        case _title = "title"
        case _description = "description"
        case _thumbnails = "thumbnails"
        case _channelTitle = "channelTitle"
        case _categoryID = "categoryId"
        case _liveBroadcastContent = "liveBroadcastContent"
    }
    
}

extension YouTubeVideoSnippetJSON: YouTubeVideoSnippet {
    
    var publishedAt: Date? {
        return DateFormatter.ISO8601.date(from: _publishedAt)
    }
    
    var channelID: String { return _channelID }
    
    var title: String { return _title }
    
    var description: String { return _description }
    
    var thumbnails: YouTubeVideoThumbnails? { return _thumbnails }
    
    var channelTitle: String { return _channelTitle }
    
    var categoryID: String { return _categoryID }
    
    var liveBroadcastContent: LiveBroadcastContent {
        switch _liveBroadcastContent {
        case "live": return .live
        case "upcoming": return .upcoming
        default: return .none
        }
    }
    
}


// MARK: - YouTube Video Thumbnails JSON

struct YouTubeVideoThumbnailsJSON: Codable {
    
    private var _default: YouTubeVideoThumbnailJSON?
    
    private var _medium: YouTubeVideoThumbnailJSON?
    
    private var _high: YouTubeVideoThumbnailJSON?
    
    enum CodingKeys: String, CodingKey {
        case _default = "default"
        case _medium = "medium"
        case _high = "high"
    }
    
}

extension YouTubeVideoThumbnailsJSON: YouTubeVideoThumbnails {
    
    var `default`: YouTubeVideoThumbnail? { return _default }
    
    var medium: YouTubeVideoThumbnail? { return _medium }
    
    var high: YouTubeVideoThumbnail? { return _high }
    
}


// MARK: - YouTube Video Thumbnail JSON

struct YouTubeVideoThumbnailJSON: Codable {
    
    private var _url: String
    
    private var _width: UInt
    
    private var _height: UInt
    
    enum CodingKeys: String, CodingKey {
        case _url = "url"
        case _width = "width"
        case _height = "height"
    }
    
}

extension YouTubeVideoThumbnailJSON: YouTubeVideoThumbnail {
    
    var url: String { return _url }
    
    var width: UInt { return _width }
    
    var height: UInt { return _height }
    
}


// MARK: - YouTube Video Content Details JSON

struct YouTubeVideoContentDetailsJSON: Codable {
    
    private var _duration: String
    
    private var _dimension: String
    
    private var _definition: String
    
    private var _caption: String
    
    private var _licensedContent: Bool
    
    private var _projection: String
    
    enum CodingKeys: String, CodingKey {
        case _duration = "duration"
        case _dimension = "dimension"
        case _definition = "definition"
        case _caption = "caption"
        case _licensedContent = "licensedContent"
        case _projection = "projection"
    }
    
}

extension YouTubeVideoContentDetailsJSON: YouTubeVideoContentDetails {
    
    var duration: UInt {
        var durationWillBeParsed = _duration
        if durationWillBeParsed.hasPrefix("P") { durationWillBeParsed.removeFirst(1) }
        let day, hour, minute, second: UInt
        if let index = durationWillBeParsed.firstIndex(of: "D") {
            day = UInt(durationWillBeParsed[..<index]) ?? 0
            durationWillBeParsed.removeSubrange(...index)
        } else { day = 0 }
        if durationWillBeParsed.hasPrefix("T") { durationWillBeParsed.removeFirst(1) }
        if let index = durationWillBeParsed.firstIndex(of: "H") {
            hour = UInt(durationWillBeParsed[..<index]) ?? 0
            durationWillBeParsed.removeSubrange(...index)
        } else { hour = 0 }
        if let index = durationWillBeParsed.firstIndex(of: "M") {
            minute = UInt(durationWillBeParsed[..<index]) ?? 0
            durationWillBeParsed.removeSubrange(...index)
        } else { minute = 0 }
        if let index = durationWillBeParsed.firstIndex(of: "S") {
            second = UInt(durationWillBeParsed[..<index]) ?? 0
        } else { second = 0 }
        return (day * 3600 * 24) + (hour * 3600) + (minute * 60) + second
    }
    
    var dimension: YouTubeVideContentDimension {
        switch _dimension {
        case "3d": return .d3d
        case "2d": return .d2d
        default: return .undefined(_dimension)
        }
    }
    
    var definition: YouTubeVideoContentDefinition {
        switch _definition {
        case "hd": return .hd
        case "sd": return .sd
        default: return .undefined(_definition)
        }
    }
    
    var caption: Bool {
        switch _caption {
        case "true": return true
        default: return false
        }
    }
    
    var licensedContent: Bool { return _licensedContent }
    
    var projection: YouTubeVideoContentProjection {
        switch _projection {
        case "360": return .p360
        case "rectangular": return .rectangular
        default: return .undefined(_projection)
        }
    }
    
}


// MARK: - YouTube Video Status JSON

struct YouTubeVideoStatusJSON: Codable {
    
    private var _uploadStatus: String
    
    private var _privacyStatus: String
    
    private var _license: String
    
    private var _embeddable: Bool
    
    private var _publicStatsViewable: Bool
    
    private var _madeForKids: Bool
    
    enum CodingKeys: String, CodingKey {
        case _uploadStatus = "uploadStatus"
        case _privacyStatus = "privacyStatus"
        case _license = "license"
        case _embeddable = "embeddable"
        case _publicStatsViewable = "publicStatsViewable"
        case _madeForKids = "madeForKids"
    }
    
}

extension YouTubeVideoStatusJSON: YouTubeVideoStatus {
    
    var uploadStatus: YouTubeVideoUploadStatus? {
        switch _uploadStatus {
        case "deleted": return .deleted
        case "failed": return .failed
        case "processed": return .processed
        case "rejected": return .rejected
        case "uploaded": return .uploaded
        default: return .undefined(_uploadStatus)
        }
    }
    
    var privacyStatus: YouTubeVideoPrivacyStatus? {
        switch _privacyStatus {
        case "private": return .private
        case "public": return .public
        case "unlisted": return .unlisted
        default: return .undefined(_privacyStatus)
        }
    }
    
    var license: YouTubeVideoLicense? {
        switch _license {
        case "creativeCommon": return .creativeCommon
        case "youTube": return .youTube
        default: return .undefined(_license)
        }
    }
    
    var embeddable: Bool { return _embeddable }
    
    var publicStatsViewable: Bool { return _publicStatsViewable }
    
    var madeForKids: Bool { return _madeForKids }
    
}


// MARK: - YouTube Video Statistics JSON

struct YouTubeVideoStatisticsJSON: Codable {
    
    private var _viewsCount: String
    
    private var _likesCount: String
    
    private var _commentsCount: String
    
    enum CodingKeys: String, CodingKey {
        case _viewsCount = "viewCount"
        case _likesCount = "likeCount"
        case _commentsCount = "commentCount"
    }
    
}

extension YouTubeVideoStatisticsJSON: YouTubeVideoStatistics {
    
    var viewsCount: UInt { return UInt(_viewsCount) ?? 0 }
    
    var likesCount: UInt { return UInt(_likesCount) ?? 0 }
    
    var commentsCount: UInt { return UInt(_commentsCount) ?? 0 }
    
}


// MARK: - YouTube Video Live Streaming Details JSON

struct YouTubeVideoLiveStreamingDetailsJSON: Codable {
    
    private var _scheduledStartTime: String?
    
    private var _activeLiveChatID: String?
    
    enum CodingKeys: String, CodingKey {
        case _scheduledStartTime = "scheduledStartTime"
        case _activeLiveChatID = "activeLiveChatId"
    }
    
}

extension YouTubeVideoLiveStreamingDetailsJSON: YouTubeVideoLiveStreamingDetails {
    
    var scheduledStartTime: Date? {
        guard let scheduledStartTimeString = _scheduledStartTime else {
            return nil
        }
        return DateFormatter.ISO8601.date(from: scheduledStartTimeString)
    }
    
    var activeLiveChatID: String? { return _activeLiveChatID }
    
}
