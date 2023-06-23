//
//  DiscordWebhook.swift
//  
//
//  Created by Bunga Mungil on 23/06/23.
//

import Foundation
import WebSubSubscriber


protocol DiscordWebhook {
    
    var forSubscription: Subscription? { get }
    
    var webhookURL: String { get }
        
    var lastPublishAt: Date? { get }
    
}
