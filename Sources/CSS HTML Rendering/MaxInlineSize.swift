//
//  MaxInlineSize.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension CSS {
    @discardableResult
    @_disfavoredOverload
    public func maxInlineSize(
        _ maxInlineSize: W3C_CSS_Logical.MaxInlineSize?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_Logical.MaxInlineSize>> {
        styled(maxInlineSize)
    }
}
