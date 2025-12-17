//
//  Outline.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension HTML.CSS {
    @discardableResult
    @_disfavoredOverload
    public func outline(
        _ outline: W3C_CSS_UI.Outline?
    ) -> HTML.CSS<HTML.Styled<Base, W3C_CSS_UI.Outline>> {
        styled(outline)
    }
}
