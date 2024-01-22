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
    
    case mayDeliverYoutubeVideos([AtomFeedEntry], SubscriptionModel)
    
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
                self = .mayDeliverYoutubeVideos(entries, subscription)
            }
        case .failure:
            self = .deliverNothing
        }
    }
    
}


extension ParsePayload: RequestHandler {
    
    public typealias ResultType = ([any YoutubeVideo & Model], SubscriptionModel)
    
    public func handle(on req: Request) async -> Result<([any YoutubeVideo & Model], SubscriptionModel), WebSubSubscriber.ErrorResponse> {
        do {
            switch self {
            case .mayDeliverYoutubeVideos(let entries, let subscription):
                return .success((
                    try await entries.asYoutubeVidoes(
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
    
    func asYoutubeVidoes(on db: Database, for subscription: Subscription) async throws -> [any YoutubeVideo & Model] {
        var result: [any YoutubeVideo & Model] = []
        for item in self {
            guard let videoID = item.yt?.videoID else {
                continue
            }
            if try await YoutubeVideoModel.query(on: db)
                .filter(\.$videoID, .equal, videoID)
                .count() > 0 {
                continue
            }
            guard let youtubeVideoModel = YoutubeVideoModel(
                entry: item,
                with: subscription
            ) else {
                continue
            }
            result.append(youtubeVideoModel)
        }
        return result
    }
    
}
