//
//  WebhookRequest.swift
//  
//
//  Created by Bunga Mungil on 23/06/23.
//

import Vapor


public struct WebhookRequest {
    
    let content: String
    
}


extension WebhookRequest: Codable { }


extension WebhookRequest: Content { }
