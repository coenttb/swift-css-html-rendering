//
//  Spacer.swift
//  swift-css-html-rendering
//

public import CSS_Standard
public import HTML_Rendering

public struct Spacer: HTML.View {
    public init() {}

    public var body: some HTML.View {
        ContentDivision {}
            .css
            .flexGrow(1)
    }
}

extension Spacer: Sendable {}
