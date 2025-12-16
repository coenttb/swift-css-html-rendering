//
//  Animation.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension CSS {
    @discardableResult
    @_disfavoredOverload
    public func animation(
        _ animation: W3C_CSS_Animations.Animation?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_Animations.Animation>> {
        styled(animation)
    }
}
