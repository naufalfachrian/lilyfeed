import Fluent
import LilyfeedKit
import Vapor
import WebSubSubscriber


func routes(_ app: Application) throws {
    try app.register(collection: SubscriberController())
    try app.register(collection: SubscriptionController())
    try app.register(collection: YouTubeVideoController())
    try app.register(collection: DiscordWebhookController())
}
