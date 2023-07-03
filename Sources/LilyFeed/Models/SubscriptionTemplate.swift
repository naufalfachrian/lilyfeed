//
//  SubscriptionTemplate.swift
//  
//
//  Created by Bunga Mungil on 02/07/23.
//

import Fluent
import Vapor
import WebSubSubscriber


public protocol SubscriptionTemplate {
    
    var name: String { get }
    
    var topic: String { get }
    
    var hub: String? { get }
    
    var leaseSeconds: Int? { get }
    
    var discordWebhookURL: String { get }
    
    var discordRoleIDToMention: String { get }
    
    var isActive: Bool { get }
    
}


// MARK: - Subscription Template Model

public final class SubscriptionTemplateModel: SubscriptionTemplate, Model, Content {
    
    public static var schema: String = "subscription_templates"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "name")
    public var name: String
    
    @Field(key: "topic")
    public var topic: String
    
    @Field(key: "hub")
    public var hub: String?
    
    @Field(key: "lease_seconds")
    public var leaseSeconds: Int?
    
    @Field(key: "discord_webhook_url")
    public var discordWebhookURL: String
    
    @Field(key: "discord_role_id_to_mention")
    public var discordRoleIDToMention: String
    
    @Field(key: "is_active")
    public var isActive: Bool
    
    public init() { }
    
    public init(
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
    
    public typealias ResultType = SubscribeRequestUseCases
    
    public func handle(on ctx: CommandContext) async -> Result<SubscribeRequestUseCases, ErrorResponse> {
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
