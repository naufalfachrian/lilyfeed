//
//  DiscordWebhookModel.swift
//  
//
//  Created by Bunga Mungil on 23/06/23.
//

import CrudifyKit
import Fluent
import Vapor
import WebSubSubscriber


final class DiscordWebhookModel: DiscordWebhook, Model, Content, HasTimestamp {
    
    static var schema: String = "discord_webhooks"
    
    @ID(key: .id)
    var id: UUID?
    
    @OptionalParent(key: "subscription_id")
    var subscription: SubscriptionModel?
    
    @Field(key: "webhook_url")
    var webhookURL: String
    
    @Field(key: "role_id_to_mention")
    var roleIdToMention: String
    
    @Field(key: "last_publish_at")
    var lastPublishAt: Date?
    
    @Field(timestamp: .createdAt)
    var createdAt: Date?
    
    @Field(timestamp: .updatedAt)
    var updatedAt: Date?
    
    var forSubscription: Subscription? {
        return self.subscription
    }
    
    init() { }
    
    init(
        _ webhookURL: String,
        for subscription: SubscriptionModel?
    ) {
        self.webhookURL = webhookURL
        self.$subscription.id = subscription?.id
        self.createdAt = Date()
    }
    
}
