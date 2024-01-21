import NIOSSL
import Fluent
import FluentMySQLDriver
import Leaf
import LilyfeedKit
import Vapor
import WebSubSubscriber
import QueuesRedisDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? MySQLConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .mysql)


    app.views.use(.leaf)
    app.migrations.add(CreateSubscriptionsTable())
    app.migrations.add(CreateYoutubeVideosTable())
    app.migrations.add(CreateUsersTable())
    app.migrations.add(CreateDiscordWebhooksTable())
    app.migrations.add(CreateSubscriptionTemplatesTable())
    
    app.commands.use(LilyfeedKit.Subscribe(), as: "subscribe")
    app.commands.use(Unsubscribe(), as: "unsubscribe")
    app.commands.use(CreateSubscriptionTemplate(), as: "create-subscription-template")
    
    app.subscriber.host(Environment.get("WEB_HOST")!)
    try app.queues.use(.redis(url: Environment.get("REDIS_HOST")!))
    
    let receiveYoutubeVideoJob = ReceiveYoutubeVideoJob()
    app.queues.add(receiveYoutubeVideoJob)

    // register routes
    try routes(app)
}
