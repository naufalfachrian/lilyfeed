//
//  ReceivingPayloadJob.swift
//
//
//  Created by Bunga Mungil on 22/01/24.
//

import Foundation
import Vapor
import Queues
import WebSubSubscriber


public struct ReceivedPayload: Codable {
    
    let data: ByteBuffer?
    
    let subscription: SubscriptionModel
    
}


public struct ReceivingPayloadJob: AsyncJob {
    
    public init() {
    }
    
    public typealias Payload = ReceivedPayload
    
    public func dequeue(_ context: QueueContext, _ payload: Payload) async throws {
        context.logger.info("Dequeue payload from subscription : \(payload.subscription.topic)")
        guard var mPayloadData = payload.data, let data = mPayloadData.readData(length: mPayloadData.readableBytes) else {
            context.logger.info("Failed to read bytes on payload data")
            return
        }
        context.logger.trace(String(data: data, encoding: .utf8))
        switch ParsePayload(data, for: payload.subscription) {
        case .deliverNothing:
            context.logger.info("Payload from subscription : \(payload.subscription.topic) deliver nothing")
        case .mayDeliverYoutubeVideos(let entries, let subscription):
            context.logger.info("Payload from subscription : \(subscription.topic) contains \(entries.count) entries")
        }
    }
    
    public func error(_ context: QueueContext, _ error: Error, _ payload: ReceivedPayload) async throws {
        context.logger.error("Error on job ReceiveYoutubeVideoJob -> \(error.localizedDescription)")
    }
    
}
