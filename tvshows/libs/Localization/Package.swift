// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Localization",
    products: [
        .library(
            name: "Localization",
            targets: ["Localization"]),
    ],
    targets: [
        .target(
            name: "Localization"),
        .testTarget(
            name: "LocalizationTests",
            dependencies: ["Localization"]),
    ]
)
