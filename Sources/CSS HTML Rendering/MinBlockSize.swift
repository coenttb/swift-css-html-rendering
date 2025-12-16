//
//  MinBlockSize.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension CSS {
    @discardableResult
    @_disfavoredOverload
    public func minBlockSize(
        _ minBlockSize: W3C_CSS_Logical.MinBlockSize?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_Logical.MinBlockSize>> {
        styled(minBlockSize)
    }
}
