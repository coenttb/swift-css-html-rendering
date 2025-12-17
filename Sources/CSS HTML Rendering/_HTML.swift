//
//  _HTML.swift
//  swift-css
//
//  Integration between CSS and HTML.View using TaskLocal context.
//

public import CSS_Standard
public import HTML_Renderable

/// Extension to convert W3C CSS Media to HTML.AtRule.Media
extension HTML.AtRule.Media {
    /// Creates an HTML.AtRule.Media from a W3C CSS Media query.
    public init(_ media: W3C_CSS_MediaQueries.Media) {
        self = .init(rawValue: media.rawValue)
    }
}

extension HTML.View {
    /// Applies a global CSS value (inherit, initial, unset, etc.) to a specific property.
    ///
    /// The at-rule, selector, and pseudo values are read from the current
    /// `HTML.Element.Style.Context` TaskLocal.
    ///
    /// ```swift
    /// div.inlineStyle(Color.self, .inherit)
    /// div.css.dark { $0.base.inlineStyle(Color.self, .initial) }
    /// ```
    ///
    /// - Parameters:
    ///   - propertyType: The CSS property type (e.g., `Color.self`).
    ///   - global: The global CSS value (inherit, initial, unset, etc.).
    /// - Returns: An HTML element with the specified global style applied.
    @discardableResult
    public func inlineStyle<PropertyType: W3C_CSS_Shared.Property>(
        _: PropertyType.Type,
        _ global: W3C_CSS_Shared.Global
    ) -> HTML.Styled<Self, GlobalProperty<PropertyType>> {
        let wrapper = GlobalProperty<PropertyType>(global)
        return self.inlineStyle(wrapper)
    }
}
