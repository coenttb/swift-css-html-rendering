//
//  HStack.swift
//  swift-css-html-rendering
//

public import CSS_Standard
public import HTML_Rendering

public struct HStack<Content: HTML.View>: HTML.View {
    let alignment: VerticalAlign
    let spacing: CSS_Standard.Length?
    let content: Content

    public init(
        alignment: VerticalAlign = .middle,
        spacing: CSS_Standard.Length? = nil,
        @HTML.Builder content: () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }

    public var body: some HTML.View {
        ContentDivision() { content }
            .css
            .alignItems(AlignItems.stretch)
            .verticalAlign(alignment)
            .display(Display.flex)
            .flexDirection(FlexDirection.row)
            .maxHeight(MaxHeight.percentage(100))
            .columnGap(ColumnGap.length(spacing == 0 ? .zero : spacing ?? 1.rem))
    }
}
