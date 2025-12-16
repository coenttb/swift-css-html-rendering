//
//  CSS.RawProperty.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 08/12/2025.
//

public import W3C_CSS_Shared

/// A wrapper that applies a raw string value to a specific property type.
///
/// This type conforms to `Property`, allowing raw string values to be used with the typed inline style API.
/// The property name comes from the wrapped `PropertyType`, while the value is the raw string provided.
///
/// This is useful for complex compound values or when you need to construct CSS values dynamically.
///
/// Example:
/// ```swift
/// // Apply a raw border value
/// div.inlineStyle(RawProperty<Border>("1px solid red"))
/// // Produces: border: 1px solid red;
/// ```
public struct RawProperty<PropertyType: W3C_CSS_Shared.Property>: W3C_CSS_Shared.Property {
    public let value: String

    public init(_ value: String) {
        self.value = value
    }

    public static var property: String {
        PropertyType.property
    }

    public var description: String {
        value
    }

    public static func global(_ global: Global) -> Self {
        Self(global.description)
    }
}
