//
//  LazyVGrid.swift
//  swift-css-html-rendering
//

public import CSS_Standard
public import HTML_Rendering
import OrderedCollections

public struct LazyVGrid<Content: HTML.View>: HTML.View {
    public let columns: OrderedDictionary<CSS_Standard.Media?, [Int]>
    public let content: Content
    public let horizontalSpacing: W3C_CSS_Multicolumn.ColumnGap?
    public let verticalSpacing: W3C_CSS_Flexbox.RowGap?

    public init(
        columns: OrderedDictionary<CSS_Standard.Media?, [Int]>,
        horizontalSpacing: W3C_CSS_Multicolumn.ColumnGap? = nil,
        verticalSpacing: W3C_CSS_Flexbox.RowGap? = nil,
        @HTML.Builder content: () -> Content
    ) {
        self.columns = columns
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.content = content()
    }

    public init(
        columns: [Int],
        horizontalSpacing: W3C_CSS_Multicolumn.ColumnGap? = nil,
        verticalSpacing: W3C_CSS_Flexbox.RowGap? = nil,
        @HTML.Builder content: () -> Content
    ) {
        self.columns = [nil: columns]
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.content = content()
    }

    public var body: some HTML.View {
        let first = columns.elements.first
        let colValues = first?.value ?? [1]
        let columnGap = horizontalSpacing == .zero ? .zero : horizontalSpacing
        let rowGap = verticalSpacing == .zero ? .zero : verticalSpacing
        let gridCols = colValues.map { "minmax(0, \($0)fr)" }.joined(separator: " ")

        ContentDivision { content }
            .css
            .width(.percent(100))
            .display(.grid)
            .inlineStyle("grid-template-columns", gridCols)
            .columnGap(columnGap)
            .rowGap(rowGap)
    }
}

extension LazyVGrid: Sendable where Content: Sendable {}
