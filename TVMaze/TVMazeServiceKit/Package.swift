// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TVMazeServiceKit",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TVMazeServiceKit",
            targets: ["TVMazeServiceKit"]),
    ],
    dependencies: [
        .package(name: "KeychainSwift", url: "https://github.com/evgenyneu/keychain-swift.git", from: "21.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TVMazeServiceKit",
            dependencies: [
                "KeychainSwift"
            ]),
        .testTarget(
            name: "TVMazeServiceKitTests",
            dependencies: ["TVMazeServiceKit"]),
    ]
)
