//
//  StrokeWidth.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension HTML.CSS {
    @discardableResult
    @_disfavoredOverload
    public func strokeWidth(
        _ strokeWidth: W3C_CSS_Images.StrokeWidth?
    ) -> HTML.CSS<HTML.Styled<Base, W3C_CSS_Images.StrokeWidth>> {
        styled(strokeWidth)
    }
}
