//
//  CSS+Builder.swift
//  swift-css
//
//  Extends the HTML Builder to handle CSS types in result builder contexts.
//  This enables CSS-styled elements to work seamlessly in for loops and other
//  builder constructs by automatically type-erasing at the builder boundary.
//

public import HTML_Renderable

// extension HTML.Builder {
//    /// Converts a CSS-wrapped view to AnyView when entering a builder context.
//    ///
//    /// This enables CSS-styled elements to work in `for` loops and other
//    /// result builder constructs where opaque types would otherwise cause issues.
//    ///
//    /// The type erasure only happens at the builder boundary, preserving
//    /// full type information during method chaining.
//    public static func buildExpression<T: HTML.View>(_ expression: CSS<T>) -> HTML.AnyView {
//        HTML.AnyView(expression as any HTML.View)
//    }
// }
