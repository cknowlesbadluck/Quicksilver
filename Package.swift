// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "QuicksilverStudio",
    platforms: [
        .iOS(.v17),
        // Lets `swift build` / `swift test` run on macOS CI (SwiftUI APIs used need macOS 14).
        .macOS(.v14)
    ],
    products: [
        .library(name: "StudioDomain", targets: ["StudioDomain"]),
        .library(name: "StudioData", targets: ["StudioData"]),
        .library(name: "StudioUI", targets: ["StudioUI"]),
        .library(name: "StackAdapters", targets: ["StackAdapters"])
    ],
    targets: [
        .target(name: "StudioDomain"),
        .target(name: "StudioData", dependencies: ["StudioDomain"]),
        .target(name: "StudioUI", dependencies: ["StudioDomain", "StudioData"]),
        .target(name: "StackAdapters", dependencies: ["StudioDomain"]),
        .testTarget(name: "StudioDomainTests", dependencies: ["StudioDomain"])
    ]
)
