//
//  YoutubeVideoController.swift
//  
//
//  Created by Bunga Mungil on 21/06/23.
//

import Vapor
import WebSubSubscriber


struct YoutubeVideoController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let routesGroup = routes.grouped("youtube-videos")
        routesGroup.get("", use: index)
    }
    
    func index(req: Request) async throws -> View {
        return try await req.view
            .render("youtube-videos-index", [
                "youtubeVideos": YoutubeVideoModel.query(on: req.db).paginate(for: req).items
            ])
    }
    
}
