//
//  TransformBox.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension CSS {
    @discardableResult
    @_disfavoredOverload
    public func transformBox(
        _ transformBox: W3C_CSS_Transforms.TransformBox?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_Transforms.TransformBox>> {
        styled(transformBox)
    }
}
