//
//  CSS+color.swift
//  swift-css
//
//  Basic color method for CSS type using Color.Value.
//  For dark mode support, import swift-html which extends with DarkModeColor methods.
//

public import CSS_Standard
public import HTML_Renderable

// extension CSS {
//    /// Sets the text color using a single Color.Value.
//    ///
//    /// This basic method applies a single color without dark mode variants.
//    /// For dark mode support, import swift-html and use the DarkModeColor overloads.
//    ///
//    /// - Parameters:
//    ///   - value: The color value to apply
//    ///   - media: Optional media query
//    ///   - selector: Optional CSS selector
//    ///   - pseudo: Optional pseudo-class/element
//    /// - Returns: A new CSS with the style applied
//    @inlinable
//    @discardableResult
//    @_disfavoredOverload
//    public func color(
//        _ value: CSS_Standard.Color.Value?,
//        media: W3C_CSS_MediaQueries.Media? = nil,
//        selector: HTML.Selector? = nil,
//        pseudo: HTML.Pseudo? = nil
//    ) -> CSS<HTML.Styled<Base, W3C_CSS_Color.Color>> {
//        let property: W3C_CSS_Color.Color? = value.map { .color($0) }
//        return styled(property, media: media, selector: selector, pseudo: pseudo)
//    }
// }
