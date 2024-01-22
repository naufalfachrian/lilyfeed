//
//  ParsePayload.swift
//  
//
//  Created by Bunga Mungil on 28/06/23.
//

import FeedKit
import Fluent
import Vapor
import WebSubSubscriber


public enum ParsePayload {
    
    case mayDeliverYouTubeVideos([AtomFeedEntry], SubscriptionModel)
    
    case deliverNothing
    
}


extension ParsePayload {
    
    public init(_ payload: Request, for subscription: SubscriptionModel) {
        guard let payloadData = payload.body.string?.data(using: .utf8) else {
            self = .deliverNothing
            return
        }
        self = .init(payloadData, for: subscription)
    }
    
    public init(_ data: Data, for subscription: SubscriptionModel) {
        switch FeedParser(data: data).parse() {
        case .success(let feed):
            let entries = feed.atomFeed?.entries ?? []
            if entries.isEmpty {
                self = .deliverNothing
            } else {
                self = .mayDeliverYouTubeVideos(entries, subscription)
            }
        case .failure:
            self = .deliverNothing
        }
    }
    
}


extension ParsePayload: RequestHandler {
    
    public typealias ResultType = ([any YouTubeVideo & Model], SubscriptionModel)
    
    public func handle(on req: Request) async -> Result<([any YouTubeVideo & Model], SubscriptionModel), WebSubSubscriber.ErrorResponse> {
        do {
            switch self {
            case .mayDeliverYouTubeVideos(let entries, let subscription):
                return .success((
                    try await entries.asYouTubeVidoes(
                        on: req.db,
                        for: subscription
                    ),
                    subscription
                ))
            case .deliverNothing:
                throw HTTPResponseStatus.noContent
            }
        } catch {
            return .failure(.init(code: .noContent))
        }
    }
    
}


fileprivate extension Sequence where Element == AtomFeedEntry {
    
    func asYouTubeVidoes(on db: Database, for subscription: Subscription) async throws -> [any YouTubeVideo & Model] {
        var result: [any YouTubeVideo & Model] = []
        for item in self {
            guard let videoID = item.yt?.videoID else {
                continue
            }
            if try await YouTubeVideoModel.query(on: db)
                .filter(\.$videoID, .equal, videoID)
                .count() > 0 {
                continue
            }
            guard let youTubeVideoModel = YouTubeVideoModel(
                entry: item,
                with: subscription
            ) else {
                continue
            }
            result.append(youTubeVideoModel)
        }
        return result
    }
    
}
