// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Voir",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Voir", type: .static, targets: ["Voir"]),
        .library(name: "VoirBuilder", type: .static, targets: ["VoirBuilder"]),
        .library(name: "VoirHooker", type: .dynamic, targets: ["VoirHooker"]),
        .executable(name: "TemplateInstaller", targets: ["TemplateInstaller"])
    ],
    dependencies: [
        // .package(url: "https://github.com/robb/Cartography", from: "4.0.0")
    ],
    targets: [
        .target(name: "Voir", dependencies: [.target(name: "VoirBuilder")]),
        .testTarget(name: "VoirTests", dependencies: [.target(name: "Voir")]),

        .target(name: "VoirBuilder", dependencies: [
            .target(name: "VoirHooker")
            // .product(name: "Cartography", package: "Cartography")
        ]),
        .testTarget(name: "VoirBuilderTests", dependencies: [.target(name: "VoirBuilder")]),

        .target(name: "VoirHooker"),

        .executableTarget(name: "TemplateInstaller")
    ]
)
