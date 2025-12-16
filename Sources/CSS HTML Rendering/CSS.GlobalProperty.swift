//
//  CSS.GlobalProperty.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 03/12/2025.
//

public import W3C_CSS_Shared

/// A wrapper that applies a global CSS value (inherit, initial, unset, etc.) to a specific property type.
///
/// This type conforms to `Property`, allowing global values to be used with the typed inline style API.
/// The property name comes from the wrapped `PropertyType`, while the value comes from the `Global` enum.
///
/// Example:
/// ```swift
/// // Apply 'inherit' to the color property
/// div.inlineStyle(Color.self, .inherit)
/// // Produces: color: inherit;
/// ```
public struct GlobalProperty<PropertyType: W3C_CSS_Shared.Property>: W3C_CSS_Shared.Property {
    public let global: Global

    public init(_ global: Global) {
        self.global = global
    }

    public static var property: String {
        PropertyType.property
    }

    public var description: String {
        global.description
    }

    public static func global(_ global: Global) -> Self {
        Self(global)
    }
}
