// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IDebugKit.UI",
    platforms: [.macOS(.v10_15),.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "IDebugKit.UI",
            targets: ["IDebugKit.UI"]),
    ],
    dependencies: [
        .package(name: "SUtilKit.SwiftUI", path: "../../SUtilKit/SwiftUI")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "IDebugKit.UI",dependencies: ["SUtilKit.SwiftUI"]),

    ]
)
