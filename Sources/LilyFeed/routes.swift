import Fluent
import Vapor
import WebSubSubscriber


func routes(_ app: Application) throws {
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    try app.register(collection: SubscriberController())
    try app.register(collection: SubscriptionController())
    try app.register(collection: YoutubeVideoController())
    try app.register(collection: DiscordWebhookController())
}
