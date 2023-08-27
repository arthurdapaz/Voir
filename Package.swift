// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Voir",
    products: [
        .library(name: "Voir", type: .static, targets: ["Voir"]),
        .executable(name: "TemplateInstaller", targets: ["TemplateInstaller"])
    ],
    targets: [
        .target(name: "Voir", exclude: ["../../Support"]),
        .testTarget(name: "VoirTests", dependencies: ["Voir"]),
        .executableTarget(name: "TemplateInstaller")
    ]
)
