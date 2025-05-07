// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "VLSplashKit",
                      platforms: [ .macOS(.v12), .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLSplashKit",
                                targets: [ "VLSplashKit" ])
                      ],
                      dependencies:
                      [
                       .package(url: "https://github.com/VLstack/VLstackNamespace", from: "1.2.0"),
                       .package(url: "https://github.com/VLstack/VLBrandKit", from: "2.6.1")
                      ],
                      targets:
                      [
                       .target(name: "VLSplashKit",
                               dependencies: [ "VLBrandKit" ])
                      ])
