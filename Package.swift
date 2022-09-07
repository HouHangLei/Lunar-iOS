// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lunar-iOS",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Lunar-iOS",
            targets: ["Lunar-iOS"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Lunar-iOS",
            dependencies: [],
            path: "Lunar-iOS",
            resources: [.process("Lunar-iOS/Assets/lunar.js")]
        ),
    ]
)
