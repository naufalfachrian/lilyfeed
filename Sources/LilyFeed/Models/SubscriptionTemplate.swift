//
//  SubscriptionTemplate.swift
//  
//
//  Created by Bunga Mungil on 02/07/23.
//

import Fluent
import Vapor
import WebSubSubscriber


protocol SubscriptionTemplate {
    
    var name: String { get }
    
    var topic: String { get }
    
    var hub: String? { get }
    
    var leaseSeconds: Int? { get }
    
    var discordWebhookURL: String { get }
    
    var discordRoleIDToMention: String { get }
    
    var isActive: Bool { get }
    
}


// MARK: - Subscription Template Model

final class SubscriptionTemplateModel: SubscriptionTemplate, Model, Content {
    
    static var schema: String = "subscription_templates"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "topic")
    var topic: String
    
    @Field(key: "hub")
    var hub: String?
    
    @Field(key: "lease_seconds")
    var leaseSeconds: Int?
    
    @Field(key: "discord_webhook_url")
    var discordWebhookURL: String
    
    @Field(key: "discord_role_id_to_mention")
    var discordRoleIDToMention: String
    
    @Field(key: "is_active")
    var isActive: Bool
    
    init() { }
    
    init(
        name: String,
        topic: String,
        hub: String?,
        leaseSeconds: Int?,
        discordWebhookURL: String,
        discordRoleIDToMention: String,
        isActive: Bool
    ) {
        self.name = name
        self.topic = topic
        self.hub = hub
        self.leaseSeconds = leaseSeconds
        self.discordWebhookURL = discordWebhookURL
        self.discordRoleIDToMention = discordRoleIDToMention
        self.isActive = isActive
    }
    
}


// MARK: - Conformance to Command Handler

extension SubscriptionTemplateModel: CommandHandler {
    
    typealias ResultType = SubscribeRequestUseCases
    
    func handle(on ctx: CommandContext) async -> Result<SubscribeRequestUseCases, ErrorResponse> {
        if let hub = self.hub {
            ctx.console.print(
                """
                Received subscribe request, with preferred hub
                topic        : \(self.topic)
                hub          : \(hub)
                leaseSeconds : \(String(describing: self.leaseSeconds))
                """
            )
            return .success(
                .subscribeWithPreferredHub(
                    topic: self.topic,
                    hub: hub,
                    leaseSeconds: self.leaseSeconds
                )
            )
        }
        ctx.console.print(
            """
            Received subscribe request, with no preferred hub
            topic        : \(self.topic)
            leaseSeconds : \(String(describing: self.leaseSeconds))
            """
        )
        return .success(
            .subscribeWithNoPreferredHub(
                topic: self.topic,
                leaseSeconds: self.leaseSeconds
            )
        )
    }
    
}
