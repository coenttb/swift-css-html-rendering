//
//  LazyVGrid.swift
//  swift-css-html-rendering
//

public import CSS_Standard
public import HTML_Rendering
public import Layout
import OrderedCollections

/// Phantom type for CSS coordinate space
public enum CSSSpace {}

public struct LazyVGrid<Content: HTML.View>: HTML.View {
    /// Column configuration type from swift-standards Layout module
    public typealias Columns = Layout<Double, CSSSpace>.Grid<Content>.Lazy.Columns

    public let columns: OrderedDictionary<CSS_Standard.Media?, Columns>
    public let content: Content
    public let horizontalSpacing: W3C_CSS_Multicolumn.ColumnGap?
    public let verticalSpacing: W3C_CSS_Flexbox.RowGap?

    public init(
        columns: OrderedDictionary<CSS_Standard.Media?, Columns>,
        horizontalSpacing: W3C_CSS_Multicolumn.ColumnGap? = nil,
        verticalSpacing: W3C_CSS_Flexbox.RowGap? = nil,
        @HTML.Builder content: () -> Content
    ) {
        self.columns = columns
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.content = content()
    }

    /// Convenience initializer with single column configuration (no media queries)
    public init(
        columns: Columns,
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
        let colValue = first?.value ?? .count(1)
        let columnGap = horizontalSpacing == .zero ? .zero : horizontalSpacing
        let rowGap = verticalSpacing == .zero ? .zero : verticalSpacing
        let gridCols = colValue.cssGridTemplateColumns

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

// MARK: - CSS Rendering for Layout.Grid.Lazy.Columns

extension Layout.Grid.Lazy.Columns where Scalar == Double {
    /// Converts the column configuration to a CSS grid-template-columns value
    var cssGridTemplateColumns: String {
        switch self {
        case .count(let n):
            return "repeat(\(n), minmax(0, 1fr))"
        case .fractions(let values):
            return values.map { "minmax(0, \(Int($0))fr)" }.joined(separator: " ")
        case .autoFill(let minWidth):
            return "repeat(auto-fill, minmax(\(Int(minWidth))px, 1fr))"
        case .autoFit(let minWidth):
            return "repeat(auto-fit, minmax(\(Int(minWidth))px, 1fr))"
        }
    }
}
