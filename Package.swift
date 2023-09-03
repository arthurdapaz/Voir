// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Voir",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Voir", type: .static, targets: ["Voir"]),
        .library(name: "VoirBuilder", type: .static, targets: ["VoirBuilder"]),
        .executable(name: "TemplateInstaller", targets: ["TemplateInstaller"])
    ],
    targets: [
        .target(name: "Voir", dependencies: [.target(name: "VoirBuilder")]),
        .testTarget(name: "VoirTests", dependencies: [.target(name: "Voir")]),

        .target(name: "VoirBuilder"),
        .testTarget(name: "VoirBuilderTests", dependencies: [.target(name: "VoirBuilder")]),

        .executableTarget(name: "TemplateInstaller")
    ]
)
