// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkSession",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "NetworkSession",
            targets: ["NetworkSession"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.1"),
        .package(url: "../Localization/Localization", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "NetworkSession",
            dependencies: ["Localization",
                           "Alamofire"],
            path: "Sources"),
        .testTarget(
            name: "NetworkSessionTests",
            dependencies: ["NetworkSession"]),
    ]
)
