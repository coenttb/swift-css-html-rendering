//
//  LightingColor.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension CSS {
    @discardableResult
    @_disfavoredOverload
    public func lightingColor(
        _ lightingColor: W3C_CSS_Color.LightingColor?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_Color.LightingColor>> {
        styled(lightingColor)
    }
}
