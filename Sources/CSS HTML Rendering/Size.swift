//
//  Size.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension CSS {
    @discardableResult
    @_disfavoredOverload
    public func size(
        _ size: W3C_CSS_Values.Size?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_Values.Size>> {
        styled(size)
    }
}
