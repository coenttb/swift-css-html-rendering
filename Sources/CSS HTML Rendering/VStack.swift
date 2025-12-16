//
//  VStack.swift
//  swift-css-html-rendering
//

public import CSS_Standard
public import HTML_Rendering

public struct VStack<Content: HTML.View>: HTML.View {
    let alignment: AlignItems
    let spacing: CSS_Standard.Length?
    let content: Content

    public init(
        alignment: AlignItems = .stretch,
        spacing: CSS_Standard.Length? = nil,
        @HTML.Builder content: () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }

    public var body: some HTML.View {
        ContentDivision() {
            content
        }
        .css
        .alignItems(alignment)
        .display(Display.flex)
        .flexDirection(FlexDirection.column)
        .maxWidth(MaxWidth.percentage(100))
        .rowGap(RowGap.length(spacing == .zero ? .zero : (spacing ?? 1.rem)))
    }
}
