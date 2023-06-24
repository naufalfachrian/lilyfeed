//
//  DiscordWebhookModel.swift
//  
//
//  Created by Bunga Mungil on 23/06/23.
//

import Fluent
import Vapor
import WebSubSubscriber


final class DiscordWebhookModel: DiscordWebhook, Model, Content {
    
    static var schema: String = "discord_webhooks"
    
    @ID(key: .id)
    var id: UUID?
    
    @OptionalParent(key: "subscription_id")
    var subscription: SubscriptionModel?
    
    @Field(key: "webhook_url")
    var webhookURL: String
    
    @Field(key: "role_id_to_mention")
    var roleIDToMention: String
    
    @Field(key: "last_publish_at")
    var lastPublishAt: Date?
    
    @Field(key: "created_at")
    var createdAt: Date?
    
    var forSubscription: Subscription? {
        return self.subscription
    }
    
    init() { }
    
    init(
        subscriptionID: UUID?,
        webhookURL: String,
        roleIDToMention: String
    ) {
        self.$subscription.id = subscriptionID
        self.webhookURL = webhookURL
        self.roleIDToMention = roleIDToMention
        self.lastPublishAt = nil
        self.createdAt = Date()
    }
    
}
