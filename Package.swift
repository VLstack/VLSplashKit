// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VLSplashKit",
    platforms: [
            .macOS(.v12), .iOS(.v15)
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "VLSplashKit",
            targets: ["VLSplashKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/VLstack/VLBrandKit.git", from: "1.0.0"),
        .package(url: "https://github.com/VLstack/VLUtilsKit", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "VLSplashKit",
            dependencies: ["VLBrandKit", "VLUtilsKit"]),
        .testTarget(
            name: "VLSplashKitTests",
            dependencies: ["VLSplashKit"]),
    ]
)
