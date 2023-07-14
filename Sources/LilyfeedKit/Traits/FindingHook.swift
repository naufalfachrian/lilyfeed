//
//  FindingHook.swift
//  
//
//  Created by Bunga Mungil on 28/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


protocol FindingHook {
    
    func findingHook(from request: Request, for payload: (videos: [any YoutubeVideo & Model], subscription: SubscriptionModel)) async throws -> Response
    
    func hook(from request: Request, for hook: Hook) async throws -> Response
    
    func hooked(from request: Request, for hook: Hook) async throws -> Response
    
}


extension FindingHook {
    
    func findingHook(from request: Request, for payload: (videos: [any YoutubeVideo & Model], subscription: SubscriptionModel)) async throws -> Response {
        return try await FindHook(
            videos: payload.videos,
            subscription: payload.subscription
        ).handle(on: request, then: self.hook)
    }
    
    func hook(from request: Request, for hook: Hook) async throws -> Response {
        return try await hook.handle(on: request, then: self.hooked)
    }
    
}
