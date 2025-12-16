//
//  ScrollMarginBottom.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension CSS {
    @discardableResult
    @_disfavoredOverload
    public func scrollMarginBottom(
        _ scrollMarginBottom: W3C_CSS_Scroll.ScrollMarginBottom?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_Scroll.ScrollMarginBottom>> {
        styled(scrollMarginBottom)
    }
}
