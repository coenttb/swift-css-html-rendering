//
//  CSS+ContextModifiers.swift
//  swift-css
//
//  Context modifier methods for CSS styling (.dark, .hover, etc.)
//

public import CSS_Standard
public import HTML_Renderable

// MARK: - Media Query Modifiers

extension CSS {
    /// Applies styles within a media query context.
    ///
    /// The styles applied within the closure inherit the media query,
    /// allowing clean dark mode and responsive styling:
    ///
    /// ```swift
    /// div.css.media(.prefersColorScheme(.dark)) { $0.color(.white) }
    /// div.css.media(.maxWidth(.px(768))) { $0.flexDirection(.column) }
    /// ```
    ///
    /// Nested contexts are merged:
    /// ```swift
    /// div.css.media(.screen) {
    ///     $0.color(.black)
    ///       .media(.prefersColorScheme(.dark)) {
    ///           $0.color(.white)  // Gets both @media screen AND prefers-color-scheme: dark
    ///       }
    /// }
    /// ```
    @inlinable
    public func media<Result: HTML.View>(
        _ media: W3C_CSS_MediaQueries.Media?,
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        let atRule = media.map { HTML.AtRule.Media($0) }
        let newContext = HTML.Style.Context.current.merging(with: .init(atRule: atRule))
        return CSS<Result>(
            base: HTML.Style.Context.$current.withValue(newContext) { content(self) }
        )
    }

    /// Applies styles for dark mode (prefers-color-scheme: dark).
    ///
    /// ```swift
    /// div.css
    ///     .color(.black)
    ///     .dark { $0.color(.white) }
    /// ```
    @inlinable
    public func dark<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        media(.prefersColorScheme(.dark), content)
    }

    /// Applies styles for light mode (prefers-color-scheme: light).
    ///
    /// ```swift
    /// div.css
    ///     .color(.white)
    ///     .light { $0.color(.black) }
    /// ```
    @inlinable
    public func light<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        media(.prefersColorScheme(.light), content)
    }

    /// Applies styles for print media.
    ///
    /// ```swift
    /// article.css.print { $0.fontSize(.pt(12)) }
    /// ```
    @inlinable
    public func print<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        media(.print, content)
    }

    /// Applies styles for screen media.
    ///
    /// ```swift
    /// div.css.screen { $0.animation(...) }
    /// ```
    @inlinable
    public func screen<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        media(.screen, content)
    }

    /// Applies styles for desktop viewport (min-width: 832px).
    ///
    /// ```swift
    /// nav.css.desktop { $0.flexDirection(.row) }
    /// ```
    @inlinable
    public func desktop<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        media(.desktop, content)
    }

    /// Applies styles for mobile viewport (max-width: 831px).
    ///
    /// ```swift
    /// nav.css.mobile { $0.flexDirection(.column) }
    /// ```
    @inlinable
    public func mobile<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        media(.mobile, content)
    }
}

// MARK: - Pseudo-Class Modifiers

extension CSS {
    /// Applies styles within a pseudo-class or pseudo-element context.
    ///
    /// ```swift
    /// div.css.pseudo(.before) { $0.content("\"→ \"") }
    /// button.css.pseudo(.hover + .focus) { $0.outline(.none) }
    /// ```
    @inlinable
    public func pseudo<Result: HTML.View>(
        _ pseudo: HTML.Pseudo?,
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        let newContext = HTML.Style.Context.current.merging(with: .init(pseudo: pseudo))
        return CSS<Result>(
            base: HTML.Style.Context.$current.withValue(newContext) { content(self) }
        )
    }

    /// Applies styles for the :hover pseudo-class.
    ///
    /// ```swift
    /// button.css
    ///     .backgroundColor(.blue)
    ///     .hover { $0.backgroundColor(.darkBlue) }
    /// ```
    @inlinable
    public func hover<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        pseudo(.hover, content)
    }

    /// Applies styles for the :focus pseudo-class.
    ///
    /// ```swift
    /// input.css
    ///     .borderColor(.gray)
    ///     .focus { $0.borderColor(.blue) }
    /// ```
    @inlinable
    public func focus<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        pseudo(.focus, content)
    }

    /// Applies styles for the :active pseudo-class.
    ///
    /// ```swift
    /// button.css
    ///     .transform(.none)
    ///     .active { $0.transform(.scale(0.98)) }
    /// ```
    @inlinable
    public func active<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        pseudo(.active, content)
    }

    /// Applies styles for the :disabled pseudo-class.
    ///
    /// ```swift
    /// button.css
    ///     .opacity(.number(1))
    ///     .disabled { $0.opacity(.number(0.5)) }
    /// ```
    @inlinable
    public func disabled<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        pseudo(.disabled, content)
    }

    /// Applies styles for the :visited pseudo-class.
    ///
    /// ```swift
    /// a.css
    ///     .color(.blue)
    ///     .visited { $0.color(.purple) }
    /// ```
    @inlinable
    public func visited<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        pseudo(.visited, content)
    }

    /// Applies styles for the :first-child pseudo-class.
    ///
    /// ```swift
    /// li.css.firstChild { $0.marginTop(.zero) }
    /// ```
    @inlinable
    public func firstChild<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        pseudo(.firstChild, content)
    }

    /// Applies styles for the :last-child pseudo-class.
    ///
    /// ```swift
    /// li.css.lastChild { $0.marginBottom(.zero) }
    /// ```
    @inlinable
    public func lastChild<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        pseudo(.lastChild, content)
    }

    /// Applies styles for the :checked pseudo-class.
    ///
    /// ```swift
    /// input.css.checked { $0.backgroundColor(.green) }
    /// ```
    @inlinable
    public func checked<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        pseudo(.checked, content)
    }

    /// Applies styles for the :placeholder-shown pseudo-class.
    ///
    /// ```swift
    /// input.css.placeholderShown { $0.color(.gray) }
    /// ```
    @inlinable
    public func placeholderShown<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        pseudo(.placeholderShown, content)
    }

    /// Applies styles for the ::before pseudo-element.
    ///
    /// ```swift
    /// div.css.before { $0.content("\"→ \"") }
    /// ```
    @inlinable
    public func before<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        pseudo(.before, content)
    }

    /// Applies styles for the ::after pseudo-element.
    ///
    /// ```swift
    /// div.css.after { $0.content("\" ←\"") }
    /// ```
    @inlinable
    public func after<Result: HTML.View>(
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        pseudo(.after, content)
    }
}

// MARK: - Selector Modifiers

extension CSS {
    /// Applies styles within a selector context.
    ///
    /// ```swift
    /// div.css.selector(.class("active")) { $0.opacity(.number(1)) }
    /// ```
    @inlinable
    public func selector<Result: HTML.View>(
        _ selector: HTML.Selector?,
        @HTML.Builder _ content: (CSS<Base>) -> Result
    ) -> CSS<Result> {
        let newContext = HTML.Style.Context.current.merging(with: .init(selector: selector))
        return CSS<Result>(
            base: HTML.Style.Context.$current.withValue(newContext) { content(self) }
        )
    }
}

// MARK: - Chained Property Modifiers

extension CSS where Base: HTML.View {
    /// Adds a dark mode variant for the same property type that was just applied.
    ///
    /// This enables a fluent chained syntax for dark mode:
    /// ```swift
    /// div.css.color(.red).dark(.blue)
    /// div.css.backgroundColor(.white).dark(.black)
    /// ```
    ///
    /// The dark mode value uses the same property type as the preceding call.
    /// The base (with original styling) is preserved and the dark variant is added on top.
    @discardableResult
    @inlinable
    public func dark<Content: HTML.View, P: W3C_CSS_Shared.Property>(
        _ property: P
    ) -> CSS<some HTML.View> where Base == HTML.Styled<Content, P> {
        // Apply dark mode style to the already-styled base, preserving the original style
        self.dark { _ in self.base.inlineStyle(property) }
    }

    /// Adds a light mode variant for the same property type that was just applied.
    ///
    /// ```swift
    /// div.css.color(.black).light(.white)
    /// ```
    @discardableResult
    @inlinable
    public func light<Content: HTML.View, P: W3C_CSS_Shared.Property>(
        _ property: P
    ) -> CSS<some HTML.View> where Base == HTML.Styled<Content, P> {
        self.light { _ in self.base.inlineStyle(property) }
    }

    /// Adds a hover variant for the same property type that was just applied.
    ///
    /// ```swift
    /// div.css.backgroundColor(.blue).hover(.darkBlue)
    /// ```
    @discardableResult
    @inlinable
    public func hover<Content: HTML.View, P: W3C_CSS_Shared.Property>(
        _ property: P
    ) -> CSS<some HTML.View> where Base == HTML.Styled<Content, P> {
        self.hover { _ in self.base.inlineStyle(property) }
    }

    /// Adds a focus variant for the same property type that was just applied.
    ///
    /// ```swift
    /// input.css.borderColor(.gray).focus(.blue)
    /// ```
    @discardableResult
    @inlinable
    public func focus<Content: HTML.View, P: W3C_CSS_Shared.Property>(
        _ property: P
    ) -> CSS<some HTML.View> where Base == HTML.Styled<Content, P> {
        self.focus { _ in self.base.inlineStyle(property) }
    }

    /// Adds an active variant for the same property type that was just applied.
    ///
    /// ```swift
    /// button.css.backgroundColor(.blue).active(.darkBlue)
    /// ```
    @discardableResult
    @inlinable
    public func active<Content: HTML.View, P: W3C_CSS_Shared.Property>(
        _ property: P
    ) -> CSS<some HTML.View> where Base == HTML.Styled<Content, P> {
        self.active { _ in self.base.inlineStyle(property) }
    }
}
