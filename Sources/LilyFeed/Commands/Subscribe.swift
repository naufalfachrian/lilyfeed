//
//  Susbcribe.swift
//  
//
//  Created by Bunga Mungil on 02/07/23.
//

import Vapor
import WebSubSubscriber


public struct Subscribe: Command {
    
    public struct Signature: CommandSignature {
        
        @Option(name: "topic", short: "t")
        var topic: String?
        
        @Option(name: "hub", short: "h")
        var hub: String?
        
        @Option(name: "lease-seconds", short: "l")
        var leaseSeconds: Int?
        
        @Flag(name: "from-template")
        var fromTemplate: Bool
        
        public init() { }
        
    }
    
    public init() { }
    
    public var help: String = "Subscribe a topic"
    
    public func run(using context: CommandContext, signature: Signature) throws {
        let promise = context
            .application
            .eventLoopGroup
            .next()
            .makePromise(of: Void.self)
        promise.completeWithTask {
            if signature.fromTemplate {
                try await fromTemplate(using: context, signature: signature)
            } else {
                try await signature.handle(on: context, then: self.subscribing)
            }
        }
        try promise.futureResult.wait()
    }
    
    func fromTemplate(using context: CommandContext, signature: Signature) async throws {
        let templates = try await SubscriptionTemplateModel
            .query(on: context.application.db)
            .filter(\.$isActive, .equal, true)
            .all()
        context.console.print("\(templates.count) templates found.")
        for template in templates {
            try await template.handle(on: context, then: { ctx, useCase in
                try await useCase.handle(on: context) { ctx, subscription in
                    let discordWebhook = DiscordWebhookModel(
                        subscriptionID: subscription.1.id,
                        webhookURL: template.discordWebhookURL,
                        roleIDToMention: template.discordRoleIDToMention
                    )
                    try await discordWebhook.save(on: context.application.db)
                    try await SubscribeRequestToHub(
                        mode: subscription.0,
                        subscription: subscription.1
                    ).handle(on: context, then: { ctx, request in
                        let response = try await context.application.client.post(
                            request.0,
                            beforeSend: request.1
                        )
                    })
                }
            })
        }
    }
    
}


extension Subscribe.Signature: CommandHandler {
    
    public typealias ResultType = SubscribeRequestUseCases
    
    public func handle(on ctx: CommandContext) async -> Result<SubscribeRequestUseCases, ErrorResponse> {
        guard let topic = self.topic else {
            ctx.console.print("Please specify the topic to subscribe when using no template")
            return .failure(.init(code: .badRequest))
        }
        if let hub = self.hub {
            ctx.console.print(
                """
                Received subscribe request, with preferred hub
                topic        : \(topic)
                hub          : \(hub)
                leaseSeconds : \(String(describing: self.leaseSeconds))
                """
            )
            return .success(
                .subscribeWithPreferredHub(
                    topic: topic,
                    hub: hub,
                    leaseSeconds: self.leaseSeconds
                )
            )
        }
        ctx.console.print(
            """
            Received subscribe request, with no preferred hub
            topic        : \(topic)
            leaseSeconds : \(String(describing: self.leaseSeconds))
            """
        )
        return .success(
            .subscribeWithNoPreferredHub(
                topic: topic,
                leaseSeconds: self.leaseSeconds
            )
        )
    }
    
}


extension Subscribe: SubscribingFromCommand { }
