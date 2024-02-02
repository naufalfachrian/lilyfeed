//
//  WebhookRequest.swift
//  
//
//  Created by Bunga Mungil on 23/06/23.
//

import Vapor


public struct WebhookRequest: Codable {
    
    let content: String
    
    let username: String?
    
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case content
        case username
        case avatarURL = "avatar_url"
    }
    
}


extension WebhookRequest: Content { }
