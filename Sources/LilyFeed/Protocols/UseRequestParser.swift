//
//  UseRequestParser.swift
//  
//
//  Created by Bunga Mungil on 21/06/23.
//

import FeedKit
import Fluent
import Vapor
import WebSubSubscriber


protocol UseRequestParser {
    
    func receiving(_ req: Request, for subscription: Subscription) async throws -> Result<[YoutubeVideo], Error>
    
}


extension UseRequestParser {
    
    func receiving(_ req: Request, for subscription: Subscription) async throws -> Result<[YoutubeVideo], Error> {
        guard let payloadData = req.body.string?.data(using: .utf8) else {
            return .success([])
        }
        switch FeedParser(data: payloadData).parse() {
        case .success(let feed):
            let videos = try await feed.atomFeed?.entries?.storeAsYoutubeVidoes(on: req.db, for: subscription) ?? []
            return.success(videos)
        case .failure:
            return .success([])
        }
    }
    
}


fileprivate extension Sequence where Element == AtomFeedEntry {
    
    func storeAsYoutubeVidoes(on db: Database, for subscription: Subscription) async throws -> [YoutubeVideo] {
        var result: [YoutubeVideo] = []
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
            try await youtubeVideoModel.save(on: db)
            result.append(youtubeVideoModel)
        }
        return result
    }
    
}
