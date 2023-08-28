// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let dependency = Target.Dependency.targetItem(name: "Voir", condition: .when(platforms: [.iOS]))

let package = Package(
    name: "Voir",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Voir", type: .static, targets: ["Voir"]),
        .executable(name: "TemplateInstaller", targets: ["TemplateInstaller"])
    ],
    targets: [
        .target(name: "Voir"),
        .testTarget(name: "VoirTests", dependencies: [dependency]),
        .executableTarget(name: "TemplateInstaller")
    ]
)
