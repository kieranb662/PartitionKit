// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PartitionKit",
    platforms: [.iOS(.v13), .macOS(.v10_15), .watchOS(.v6)],
    products: [
        .library(
            name: "PartitionKit",
            targets: ["PartitionKit"]),
    ],
    targets: [
        .target(
            name: "PartitionKit",
            dependencies: []),
    ]
)
