//
//  YouTubeVideoController.swift
//
//
//  Created by Bunga Mungil on 21/06/23.
//

import Vapor
import WebSubSubscriber


public struct YouTubeVideoController: RouteCollection {
    
    public init() { }
    
    public func boot(routes: RoutesBuilder) throws {
        let routesGroup = routes.grouped("youtube-videos")
        routesGroup.get("", use: index)
    }
    
    func index(req: Request) async throws -> View {
        return try await req.view
            .render("youtube-videos-index", [
                "youTubeVideos": YouTubeVideoModel.query(on: req.db).paginate(for: req).items
            ])
    }
    
}
