//
//  CSS.swift
//  swift-css
//
//  Provides namespaced access to CSS properties for better discoverability.
//  Usage: `div.css.color(.red).padding(.px(16)).display(.flex)`
//
//  The `.css` accessor returns an `HTML.HTML.CSS<Base>` type, grouping CSS properties
//  for easier autocomplete discovery. Once in the CSS namespace,
//  you can chain methods fluently without repeating `.css`.
//

public import CSS_Standard
public import HTML_Renderable

/// Provides namespaced access to CSS properties for better discoverability.
///
/// Access CSS properties through the `.css` accessor on any `HTML.View`,
/// then chain methods fluently within the namespace:
/// ```swift
/// div.css
///     .color(.red)
///     .padding(.px(16))
///     .display(.flex)
/// ```
///
/// `HTML.CSS` conforms to `HTML.View`, so it can be used directly
/// anywhere an `HTML.View` is expected - no explicit unwrapping required:
/// ```swift
/// var body: some HTML.View {
///     div.css.color(.red).padding(.px(16))
/// }
/// ```
///
/// The namespace helps with autocomplete discoverability and provides
/// disambiguation when types conform to both `HTML.View` and `SwiftUI.View`.
extension HTML {
    public struct CSS<Base: HTML.View>: HTML.View {
        public let base: Base

        @inlinable
        public init(base: Base) {
            self.base = base
        }

        // MARK: - HTML.View Conformance

        @inlinable
        public var body: Base {
            base
        }
    }
}

/// CSS namespace for the result builder.
///
/// Use `@CSS.Builder` to annotate functions that return `HTML.CSS<some HTML.View>`.
public enum CSS {
    // MARK: - CSS.Builder Result Builder

    /// A result builder for constructing CSS-wrapped HTML views.
    ///
    /// Use `@CSS.Builder` to annotate functions that return `HTML.CSS<some HTML.View>`,
    /// enabling the same DSL syntax as `@HTML.Builder` while automatically
    /// wrapping the result in an `HTML.CSS` wrapper:
    ///
    /// ```swift
    /// extension HTML.CSS {
    ///     @CSS.Builder
    ///     func applyColor(_ color: Color?) -> HTML.CSS<some HTML.View> {
    ///         if let color {
    ///             base.inlineStyle(Color.color(color))
    ///         } else {
    ///             base
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// This builder reuses the same transformation logic as `HTML.Builder` (from Renderable),
    /// but wraps the final result in `HTML.CSS<...>` via `buildFinalResult`.
    @resultBuilder
    public enum Builder {
        // Pass through expressions unchanged (same as HTML.Builder)
        @inlinable
        public static func buildExpression<T>(_ expression: T) -> T {
            expression
        }

        // Pass through single block unchanged (same as HTML.Builder)
        @inlinable
        public static func buildBlock<Content>(_ content: Content) -> Content {
            content
        }

        // Handle multiple components as tuple (same as HTML.Builder)
        @inlinable
        public static func buildBlock<each Content>(
            _ content: repeat each Content
        ) -> _Tuple<repeat each Content> {
            _Tuple(repeat each content)
        }

        // Handle if-else: first branch (same as HTML.Builder)
        @inlinable
        public static func buildEither<First, Second>(
            first component: First
        ) -> _Conditional<First, Second> {
            .first(component)
        }

        // Handle if-else: second branch (same as HTML.Builder)
        @inlinable
        public static func buildEither<First, Second>(
            second component: Second
        ) -> _Conditional<First, Second> {
            .second(component)
        }

        // Handle optional (if without else) (same as HTML.Builder)
        @inlinable
        public static func buildOptional<T>(_ component: T?) -> T? {
            component
        }

        // Handle arrays from for loops (same as HTML.Builder)
        @inlinable
        public static func buildArray<Element>(_ components: [Element]) -> _Array<Element> {
            _Array(components)
        }

        // The key difference: wrap the final result in HTML.CSS
        @inlinable
        public static func buildFinalResult<Content: HTML.View>(
            _ component: Content
        ) -> HTML.CSS<Content> {
            HTML.CSS<Content>(base: component)
        }
    }
}

extension HTML.CSS: Sendable where Base: Sendable {}

// MARK: - Global CSS Builder Function

/// Creates an HTML.CSS wrapper with type inference from the builder result.
///
/// Use this function when you need to conditionally construct CSS content
/// while preserving the concrete type information:
/// ```swift
/// func applyColor(_ color: Color?) -> HTML.CSS<some HTML.View> {
///     cssBuilder {
///         if let color {
///             base.inlineStyle(Color.color(color))
///         } else {
///             base
///         }
///     }
/// }
/// ```
///
/// This is preferred over the `HTML.CSS { }` init inside extensions because
/// Swift cannot infer a different type parameter than `Base` in that context.
@inlinable
public func cssBuilder<Content: HTML.View>(
    @HTML.Builder _ content: () -> Content
) -> HTML.CSS<Content> {
    HTML.CSS<Content>(base: content())
}

extension HTML.CSS {
    // MARK: - Inline Style Helper

    /// Applies an inline style and returns a CSS wrapper with the styled content.
    ///
    /// The at-rule, selector, and pseudo values are read from the current
    /// `HTML.Element.Style.Context` TaskLocal, allowing context-based styling:
    ///
    /// ```swift
    /// div.css.dark { $0.color(.white) }  // Uses .dark context
    /// button.css.hover { $0.backgroundColor(.blue) }  // Uses :hover context
    /// ```
    @inlinable
    func styled<P: W3C_CSS_Shared.Property>(_ property: P?) -> HTML.CSS<HTML.Styled<Base, P>> {
        HTML.CSS<HTML.Styled<Base, P>>(base: base.inlineStyle(property))
    }

    // MARK: - String-based Inline Style

    /// Applies an inline style using string property name and value.
    ///
    /// Use this for dynamic properties or edge cases where typed properties aren't available.
    /// Prefer typed properties when possible for better type safety.
    ///
    /// The at-rule, selector, and pseudo values are read from the current
    /// `HTML.Element.Style.Context` TaskLocal.
    ///
    /// ```swift
    /// div.css
    ///     .inlineStyle("grid-template-columns", "1fr 1fr 1fr")
    ///     .inlineStyle("custom-property", "value")
    ///
    /// // With context:
    /// div.css.dark { $0.inlineStyle("custom-property", "dark-value") }
    /// ```
    @inlinable
    @discardableResult
    @CSS.Builder
    public func inlineStyle(
        _ property: String,
        _ value: String?
    ) -> HTML.CSS<some HTML.View> {
        if let value {
            HTML.CSS<HTML.Styled<Base, StringProperty>>(
                base: base.inlineStyle(StringProperty(property, value))
            )
        } else {
            base
        }

    }
}

// MARK: - HTML.View Extension

extension HTML.View {
    /// Access CSS properties through a namespaced accessor for better discoverability.
    ///
    /// The `.css` accessor provides fluent chaining within the namespace:
    /// ```swift
    /// div.css
    ///     .color(.red)
    ///     .padding(.px(16))
    ///     .display(.flex)
    /// ```
    ///
    /// `HTML.CSS` conforms to `HTML.View`, so no explicit unwrapping
    /// is needed - use it directly in result builders and `some HTML.View` returns.
    @inlinable
    public var css: HTML.CSS<Self> {
        HTML.CSS(base: self)
    }
}
