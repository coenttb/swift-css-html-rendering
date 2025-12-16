//
//  LineHeight.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension CSS {
    @discardableResult
    @_disfavoredOverload
    public func lineHeight(
        _ lineHeight: W3C_CSS_Text.LineHeight?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_Text.LineHeight>> {
        styled(lineHeight)
    }
}

extension CSS {
    @discardableResult
    @_disfavoredOverload
    public func lineHeight<T: BinaryInteger>(
        _ lineHeight: T?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_Text.LineHeight>> {
        styled(lineHeight.map { LineHeight(integerLiteral: Int($0)) })
    }

    @discardableResult
    @_disfavoredOverload
    public func lineHeight<T: BinaryFloatingPoint>(
        _ lineHeight: T?
    ) -> CSS<HTML.Styled<Base, W3C_CSS_Text.LineHeight>> {
        styled(lineHeight.map { LineHeight(floatLiteral: Double($0)) })
    }
}
