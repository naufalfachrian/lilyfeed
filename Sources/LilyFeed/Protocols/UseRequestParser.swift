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
    
    func parse(_ req: Request, for subscription: Subscription) async throws -> Result<[YoutubeVideo], Error>
    
}


extension UseRequestParser {
    
    func parse(_ req: Request, for subscription: Subscription) async throws -> Result<[YoutubeVideo], Error> {
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
        let items = self.flatMap { entry in
            guard let youtubeVideoModel = YoutubeVideoModel(
                entry: entry,
                with: subscription
            ) else {
                return [] as [YoutubeVideoModel]
            }
            return [youtubeVideoModel]
        }
        for item in items {
            try await item.save(on: db)
        }
        return items
    }
    
}
