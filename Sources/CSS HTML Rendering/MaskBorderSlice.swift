//
//  MaskBorderSlice.swift
//  swift-html
//
//  Created by Coen ten Thije Boonkkamp on 02/04/2025.
//

public import CSS_Standard
public import HTML_Renderable

extension HTML.CSS {
    @discardableResult
    @_disfavoredOverload
    public func maskBorderSlice(
        _ maskBorderSlice: W3C_CSS_Masking.MaskBorderSlice?
    ) -> HTML.CSS<HTML.Styled<Base, W3C_CSS_Masking.MaskBorderSlice>> {
        styled(maskBorderSlice)
    }
}
