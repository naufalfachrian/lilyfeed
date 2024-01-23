//
//  CreateSubscriptionTemplate.swift
//  
//
//  Created by Bunga Mungil on 02/07/23.
//

import Vapor
import WebSubSubscriber


public struct CreateSubscriptionTemplate: AsyncCommand {
    
    public struct Signature: CommandSignature {
        
        @Argument(name: "name")
        var name: String
        
        @Argument(name: "topic")
        var topic: String
        
        @Argument(name: "discord-webhook-url")
        var discordWebhookURL: String
        
        @Argument(name: "discord-role-id-to-mention")
        var discordRoleIDToMention: String
        
        @Option(name: "hub")
        var hub: String?
        
        @Option(name: "lease-seconds")
        var leaseSeconds: Int?
        
        public init() { }
        
    }
    
    public init() { }
    
    public var help: String = "Create subscription template"
    
    public func run(using context: CommandContext, signature: Signature) async throws {
        let template = SubscriptionTemplateModel(from: signature)
        try await template.save(on: context.application.db)
        context.console.print("Template \(template.name) created and saved!")
    }
    
}


extension SubscriptionTemplateModel {
    
    public convenience init(from signature: CreateSubscriptionTemplate.Signature) {
        self.init(
            name: signature.name,
            topic: signature.topic,
            hub: signature.hub,
            leaseSeconds: signature.leaseSeconds,
            discordWebhookURL: signature.discordWebhookURL,
            discordRoleIDToMention: signature.discordRoleIDToMention,
            isActive: true
        )
    }
    
}
