# swift-css-html-render

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Applies typed CSS properties to HTML views through a fluent `.css` namespace.

> SwiftUI-style layout views (`HStack`, `VStack`, `Spacer`, lazy grid) live in the sibling `swift-css-html-layout-render` package. Consumers reach them transparently via `import HTML`.

---

## Key Features

- **Typed property modifiers** — each CSS property is a method that takes the value type from its W3C module (`.width(.px(200))`, `.display(.flex)`, `.alignItems(.center)`), so unsupported values are rejected at compile time.
- **Fluent `.css` namespace** — `.css` on any `HTML.View` opens a namespace you chain within without repeating the accessor.
- **Composes as an `HTML.View`** — `HTML.CSS` itself conforms to `HTML.View`, so styled output drops into any HTML builder with no unwrapping.
- **Result-builder integration** — `@CSS.Builder` and the `cssBuilder { }` function produce `HTML.CSS<some HTML.View>` for conditional styling.
- **Inline-style escape hatch** — `.inlineStyle("grid-template-columns", "1fr 1fr 1fr")` covers properties without a typed modifier.

---

## Quick Start

```swift
import CSS_HTML_Rendering

// Open the `.css` namespace on any HTML view, then chain typed CSS
// properties — each modifier takes the value type from its W3C module.
let card = ContentDivision { }
    .css
    .display(.flex)
    .flexDirection(.column)
    .alignItems(.center)
    .padding(.px(16))
    .backgroundColor(.color(.named(.white)))
    .color(.named(.black))
```

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-compositions/swift-css-html-render.git", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "CSS HTML Rendering", package: "swift-css-html-render"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26.

---

## Architecture

Two library products: the rendering module and a test-support module.

| Product | Target | Purpose |
|---------|--------|---------|
| `CSS HTML Rendering` | `Sources/CSS HTML Rendering/` | The `.css` accessor and `HTML.CSS<Base>` wrapper, the typed property modifiers, and the `CSS.Builder` result builder and `cssBuilder` function. |
| `CSS HTML Rendering Test Support` | `Tests/Support/` | Re-exports the rendering module for test consumers. |

The module name is `CSS_HTML_Rendering` once imported. Property values come from the W3C CSS modules in `CSS Standard`; the HTML view types come from `HTML Rendering`.

---

## Community

<!-- BEGIN: discussion -->
*Discussion thread will be created at first public release.*
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE](LICENSE.md).
