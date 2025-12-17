// swift-tools-version: 6.2

import PackageDescription

extension String {
    static let cssHTMLRendering: Self = "CSS HTML Rendering"
}

extension Target.Dependency {
    static var cssHTMLRendering: Self { .target(name: .cssHTMLRendering) }
}

extension Target.Dependency {
    static var cssStandard: Self {
        .product(name: "CSS Standard", package: "swift-css-standard")
    }
    static var htmlRenderable: Self {
        .product(name: "HTML Renderable", package: "swift-html-rendering")
    }
    static var htmlRendering: Self {
        .product(name: "HTML Rendering", package: "swift-html-rendering")
    }
    static var htmlRenderableTestSupport: Self {
        .product(name: "HTML Rendering TestSupport", package: "swift-html-rendering")
    }
}

let package = Package(
    name: "swift-css-html-rendering",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(name: .cssHTMLRendering, targets: [.cssHTMLRendering]),
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/swift-html-rendering", from: "0.1.10"),
        .package(url: "https://github.com/swift-standards/swift-css-standard", from: "0.1.6"),
    ],
    targets: [
        .target(
            name: .cssHTMLRendering,
            dependencies: [
                .htmlRendering,
                .cssStandard,
            ]
        ),
        .testTarget(
            name: .cssHTMLRendering.tests,
            dependencies: [
                .cssHTMLRendering,
                .htmlRenderableTestSupport
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { self + " Tests" }
}

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let existing = target.swiftSettings ?? []
    target.swiftSettings = existing + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportsByDefault")
    ]
}
