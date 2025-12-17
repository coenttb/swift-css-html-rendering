//
//  ColorInterpolationFilters.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension HTML.CSS {
    @discardableResult
    @_disfavoredOverload
    public func colorInterpolationFilters(
        _ colorInterpolationFilters: W3C_CSS_Color.ColorInterpolationFilters?
    ) -> HTML.CSS<HTML.Styled<Base, W3C_CSS_Color.ColorInterpolationFilters>> {
        styled(colorInterpolationFilters)
    }
}
