// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "lilyfeed",
    platforms: [
       .macOS(.v12)
    ],
    products: [
        .library(
            name: "LilyfeedKit",
            targets: ["LilyfeedKit"]
        )
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.76.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
        .package(url: "https://github.com/WebSubKit/websub-subscriber.git", from: "0.13.3"),
        .package(url: "https://github.com/vapor/queues-redis-driver.git", from: "1.1.1"),
    ],
    targets: [
        .executableTarget(
            name: "Lilyfeed",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "WebSubSubscriber", package: "websub-subscriber"),
                .product(name: "QueuesRedisDriver", package: "queues-redis-driver"),
                .target(name: "LilyfeedKit")
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://www.swift.org/server/guides/building.html#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .target(
            name: "LilyfeedKit",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "WebSubSubscriber", package: "websub-subscriber"),
            ]
        ),
        .testTarget(name: "LilyfeedTests", dependencies: [
            .target(name: "Lilyfeed"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
