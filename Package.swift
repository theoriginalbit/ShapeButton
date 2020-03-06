// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "UIButton+setBackgroundColor",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(name: "UIButton+setBackgroundColor", targets: ["UIButton+setBackgroundColor"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "UIButton+setBackgroundColor"),
    ])
