//
//  PaddingRight.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension CSS {
    @discardableResult
    @_disfavoredOverload
    public func paddingRight(
        _ paddingRight: W3C_CSS_BoxModel.PaddingRight?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_BoxModel.PaddingRight>> {
        styled(paddingRight)
    }
}
