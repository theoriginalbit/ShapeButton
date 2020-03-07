// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ShapeButton",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(name: "ShapeButton", targets: ["ShapeButton"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "ShapeButton"),
    ])
