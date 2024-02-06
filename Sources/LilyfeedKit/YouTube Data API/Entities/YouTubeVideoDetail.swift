//
//  YouTubeVideoDetail.swift
//
//
//  Created by Bunga Mungil on 31/01/24.
//

import Foundation


struct YouTubeVideoDetail: Codable {
    
    var eTag: String
    
    var id: String
    
    var snippet: YouTubeVideoSnippet
    
    var contentDetails: YouTubeVideoContentDetails
    
    var status: YouTubeVideoStatus
    
    var statistics: YouTubeVideoStatistics
    
    var liveStreamingDetails: YouTubeVideoLiveStreamingDetails?
    
    enum CodingKeys: String, CodingKey {
        case eTag = "etag"
        case id = "id"
        case snippet = "snippet"
        case contentDetails = "contentDetails"
        case status = "status"
        case statistics = "statistics"
        case liveStreamingDetails = "liveStreamingDetails"
    }
    
}


// MARK: - YouTube Video Snippet

struct YouTubeVideoSnippet: Codable {
    
    var publishedAt: String
    
    var channelID: String
    
    var title: String
    
    var description: String
    
    var thumbnails: YouTubeVideoThumbnails?
    
    var channelTitle: String
    
    var categoryID: String
    
    var liveBroadcastContent: String
    
    enum CodingKeys: String, CodingKey {
        case publishedAt = "publishedAt"
        case channelID = "channelId"
        case title = "title"
        case description = "description"
        case thumbnails = "thumbnails"
        case channelTitle = "channelTitle"
        case categoryID = "categoryId"
        case liveBroadcastContent = "liveBroadcastContent"
    }
    
}


// MARK: - YouTube Video Thumbnails

struct YouTubeVideoThumbnails: Codable {
    
    var `default`: YouTubeVideoThumbnail?
    
    var medium: YouTubeVideoThumbnail?
    
    var high: YouTubeVideoThumbnail?
    
    enum CodingKeys: String, CodingKey {
        case `default` = "default"
        case medium = "medium"
        case high = "high"
    }
    
}


// MARK: - YouTube Video Thumbnail

struct YouTubeVideoThumbnail: Codable {
    
    var url: String
    
    var width: UInt
    
    var height: UInt
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case width = "width"
        case height = "height"
    }
    
}


// MARK: - YouTube Video Content Details

struct YouTubeVideoContentDetails: Codable {
    
    var duration: UInt
    
    var dimension: YouTubeVideoContentDimension
    
    var definition: YouTubeVideoContentDefinition
    
    var caption: Bool
    
    var licensedContent: Bool
    
    var projection: YouTubeVideoContentProjection
    
    enum CodingKeys: String, CodingKey {
        case duration = "duration"
        case dimension = "dimension"
        case definition = "definition"
        case caption = "caption"
        case licensedContent = "licensedContent"
        case projection = "projection"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let duration = try container.decode(String.self, forKey: .duration)
        var durationWillBeParsed = duration
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
        self.duration = (day * 3600 * 24) + (hour * 3600) + (minute * 60) + second
        self.dimension = try container.decode(YouTubeVideoContentDimension.self, forKey: .dimension)
        self.definition = try container.decode(YouTubeVideoContentDefinition.self, forKey: .definition)
        let caption = try container.decode(String.self, forKey: .caption)
        switch caption {
        case "true": self.caption = true
        default: self.caption = false
        }
        self.licensedContent = try container.decode(Bool.self, forKey: .licensedContent)
        self.projection = try container.decode(YouTubeVideoContentProjection.self, forKey: .projection)
    }
    
}


// MARK: - YouTube Video Status

struct YouTubeVideoStatus: Codable {
    
    var uploadStatus: YouTubeVideoUploadStatus
    
    var privacyStatus: YouTubeVideoPrivacyStatus
    
    var license: YouTubeVideoLicense
    
    var embeddable: Bool
    
    var publicStatsViewable: Bool
    
    var madeForKids: Bool
    
    enum CodingKeys: String, CodingKey {
        case uploadStatus = "uploadStatus"
        case privacyStatus = "privacyStatus"
        case license = "license"
        case embeddable = "embeddable"
        case publicStatsViewable = "publicStatsViewable"
        case madeForKids = "madeForKids"
    }
    
}


// MARK: - YouTube Video Statistics

struct YouTubeVideoStatistics: Codable {
    
    var viewsCount: UInt
    
    var likesCount: UInt
    
    var commentsCount: UInt
    
    enum CodingKeys: String, CodingKey {
        case viewsCount = "viewCount"
        case likesCount = "likeCount"
        case commentsCount = "commentCount"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.viewsCount = UInt(try container.decode(String.self, forKey: .viewsCount)) ?? 0
        self.likesCount = UInt(try container.decode(String.self, forKey: .likesCount)) ?? 0
        self.commentsCount = UInt(try container.decode(String.self, forKey: .commentsCount)) ?? 0
    }
    
}


// MARK: - YouTube Video Live Streaming Details

struct YouTubeVideoLiveStreamingDetails: Codable {
    
    var scheduledStartTime: Date?
    
    var activeLiveChatID: String?
    
    enum CodingKeys: String, CodingKey {
        case scheduledStartTime = "scheduledStartTime"
        case activeLiveChatID = "activeLiveChatId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.scheduledStartTime = try container.decodeIfPresent(Date.self, forKey: .scheduledStartTime)
        self.activeLiveChatID = try container.decodeIfPresent(String.self, forKey: .activeLiveChatID)
    }
    
}


// MARK: - Enums

enum YouTubeVideoUploadStatus: Codable {
    case deleted
    case failed
    case processed
    case rejected
    case uploaded
    case undefined(_ raw: String)
    
    init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)
        switch raw {
        case "deleted": self = .deleted
        case "failed": self = .failed
        case "processed": self = .processed
        case "rejected": self = .rejected
        case "uploaded": self = .uploaded
        default: self = .undefined(raw)
        }
    }
}


enum YouTubeVideoPrivacyStatus: Codable {
    case `private`
    case `public`
    case unlisted
    case undefined(_ raw: String)
    
    init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)
        switch raw {
        case "private": self = .private
        case "public": self = .public
        case "unlisted": self = .unlisted
        default: self = .undefined(raw)
        }
    }
}


enum YouTubeVideoLicense: Codable {
    case creativeCommon
    case youTube
    case undefined(_ raw: String)
    
    init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)
        switch raw {
        case "creativeCommon": self = .creativeCommon
        case "youTube": self = .youTube
        default: self = .undefined(raw)
        }
    }
}


enum YouTubeVideoContentDimension: Codable {
    case d2d
    case d3d
    case undefined(_ raw: String)
    
    init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)
        switch raw {
        case "3d": self = .d3d
        case "2d": self = .d2d
        default: self = .undefined(raw)
        }
    }
}


enum YouTubeVideoContentDefinition: Codable {
    case hd
    case sd
    case undefined(_ raw: String)
    
    init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)
        switch raw {
        case "hd": self = .hd
        case "sd": self = .sd
        default: self = .undefined(raw)
        }
    }
}


enum YouTubeVideoContentProjection: Codable {
    case p360
    case rectangular
    case undefined(_ raw: String)
    
    init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)
        switch raw {
        case "360": self = .p360
        case "rectangular": self = .rectangular
        default: self = .undefined(raw)
        }
    }
}
