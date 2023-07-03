//
//  YoutubeVideo.swift
//  
//
//  Created by Bunga Mungil on 21/06/23.
//

import FeedKit
import Fluent
import Vapor
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


// MARK: - Youtube Video Sequence

extension Sequence where Element == any YoutubeVideo & Model {
    
    func ids(separator: String) -> String {
        self.map { item in item.channelID }.joined(separator: separator)
    }
    
}


// MARK: - Youtube Video Model

final class YoutubeVideoModel: YoutubeVideo, Model, Content {
    
    static let schema: String = "youtube_videos"
    
    @ID(key: .id)
    var id: UUID?
    
    @OptionalParent(key: "subscription_id")
    var subscription: SubscriptionModel?
    
    @Field(key: "channel_id")
    var channelID: String
    
    @Field(key: "channel_name")
    var channelName: String
    
    @Field(key: "channel_url")
    var channelURL: String
    
    @Field(key: "video_id")
    var videoID: String
    
    @Field(key: "video_title")
    var videoTitle: String
    
    @Field(key: "video_url")
    var videoURL: String
    
    @Field(key: "published_at")
    var publishedAt: Date
    
    @Field(key: "created_at")
    var createdAt: Date
    
    var fromSubscription: Subscription? {
        return self.subscription
    }
    
    init() { }
    
    init(
        subscription: SubscriptionModel?,
        channelID: String,
        channelName: String,
        channelURL: String,
        videoID: String,
        videoTitle: String,
        videoURL: String,
        publishedAt: Date
    ) {
        self.$subscription.id = subscription?.id
        self.channelID = channelID
        self.channelName = channelName
        self.channelURL = channelURL
        self.videoID = videoID
        self.videoTitle = videoTitle
        self.videoURL = videoURL
        self.publishedAt = publishedAt
        self.createdAt = Date()
    }
    
}


extension YoutubeVideoModel {
    
    convenience init?(entry: AtomFeedEntry, with subscription: Subscription) {
        guard let yt = entry.yt else {
            return nil
        }
        guard let channelID = yt.channelID else {
            return nil
        }
        guard let channelName = entry.authors?.last?.name else {
            return nil
        }
        guard let channelURLString = entry.authors?.last?.uri else {
            return nil
        }
        guard let videoID = yt.videoID else {
            return nil
        }
        guard let videoTitle = entry.title else {
            return nil
        }
        guard let videoURLString = entry.links?.last?.attributes?.href else {
            return nil
        }
        guard let publishedAt = entry.published else {
            return nil
        }
        self.init(
            subscription: subscription as? SubscriptionModel,
            channelID: channelID,
            channelName: channelName,
            channelURL: channelURLString,
            videoID: videoID,
            videoTitle: videoTitle,
            videoURL: videoURLString,
            publishedAt: publishedAt
        )
    }
    
}
