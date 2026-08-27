// swift-tools-version: 6.4

import PackageDescription

extension String {
    static let cssHTMLRendering: Self = "CSS HTML Rendering"
    var tests: Self { self + " Tests" }
}

extension Target.Dependency {
    static var cssHTMLRendering: Self { .target(name: .cssHTMLRendering) }
}

extension Target.Dependency {
    static var cssStandard: Self {
        .product(name: "CSS Standard", package: "swift-css-standard")
    }
    static var htmlRenderingCore: Self {
        .product(name: "HTML Rendering Core", package: "swift-html-render")
    }
    static var htmlRendering: Self {
        .product(name: "HTML Rendering", package: "swift-html-render")
    }
}

let package = Package(
    name: "swift-css-html-render",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: .cssHTMLRendering, targets: [.cssHTMLRendering]),
        .library(
            name: "CSS HTML Rendering Test Support",
            targets: ["CSS HTML Rendering Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-compositions/swift-html-render.git", branch: "main"),
        .package(url: "https://github.com/swift-standards/swift-css-standard.git", branch: "main"),
    ],
    targets: [
        .target(
            name: .cssHTMLRendering,
            dependencies: [
                .htmlRendering,
                .cssStandard,
            ]
        ),
        .target(
            name: "CSS HTML Rendering Test Support",
            dependencies: [
                .cssHTMLRendering,
                .cssStandard,
                .product(name: "HTML Rendering Core Test Support", package: "swift-html-render"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: .cssHTMLRendering.tests,
            dependencies: [
                "CSS HTML Rendering Test Support"
            ],
            path: "Tests/CSS HTML Rendering Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
