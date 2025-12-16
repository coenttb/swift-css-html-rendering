//
//  ScrollPaddingInline.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension CSS {
    @discardableResult
    @_disfavoredOverload
    public func scrollPaddingInline(
        _ scrollPaddingInline: W3C_CSS_Scroll.ScrollPaddingInline?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_Scroll.ScrollPaddingInline>> {
        styled(scrollPaddingInline)
    }
}
