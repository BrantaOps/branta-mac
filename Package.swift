// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Branta",
    defaultLocalization: "en",
    dependencies: [
    ],
    targets: [
        .target(name: "Branta", dependencies: [], path: "branta/"),
        .testTarget(name: "BrantaTests", dependencies: [], path: "brantaTests/"),
    ]
)
