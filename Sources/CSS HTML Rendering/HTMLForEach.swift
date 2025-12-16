//
//  HTMLForEach.swift
//  swift-css-html-rendering
//

public import HTML_Rendering

public struct HTMLForEach<Content: HTML.View>: HTML.View {
    /// The array of HTML content generated from the collection.
    let content: _Array<Content>

    /// Creates a new HTML component that generates content for each element in a collection.
    ///
    /// - Parameters:
    ///   - data: The collection to iterate over.
    ///   - content: A closure that transforms each element of the collection into HTML content.
    public init<Data: Sequence>(
        _ data: Data,
        @HTML.Builder content: (Data.Element) -> Content
    ) {
        self.content = HTML.Builder.buildArray(data.map(content))
    }

    /// The body of this component, which is the array of HTML content.
    public var body: some HTML.View {
        content
    }
}
