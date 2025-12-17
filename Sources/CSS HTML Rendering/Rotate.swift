//
//  Rotate.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension HTML.CSS {
    @discardableResult
    @_disfavoredOverload
    public func rotate(
        _ rotate: W3C_CSS_Transforms.Rotate?
    ) -> HTML.CSS<HTML.Styled<Base, W3C_CSS_Transforms.Rotate>> {
        styled(rotate)
    }
}
