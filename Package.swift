// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "lily-feed",
    platforms: [
       .macOS(.v12)
    ],
    products: [
        .library(
            name: "LilyFeedKit",
            targets: ["LilyFeedKit"]
        )
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.76.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
        .package(url: "https://github.com/WebSubKit/websub-subscriber.git", from: "0.13.3"),
    ],
    targets: [
        .executableTarget(
            name: "LilyFeed",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "WebSubSubscriber", package: "websub-subscriber"),
                .target(name: "LilyFeedKit")
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://www.swift.org/server/guides/building.html#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .target(
            name: "LilyFeedKit",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "WebSubSubscriber", package: "websub-subscriber"),
            ]
        ),
        .testTarget(name: "LilyFeedTests", dependencies: [
            .target(name: "LilyFeed"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
