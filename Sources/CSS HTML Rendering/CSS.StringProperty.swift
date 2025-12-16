//
//  CSS.StringProperty.swift
//  swift-css
//
//  Created by Coen ten Thije Boonkkamp on 08/12/2025.
//

public import W3C_CSS_Shared

/// A string-based CSS property that holds both property name and value.
///
/// This type allows for dynamic property names at runtime, unlike typed properties
/// which have static property names. It's useful for edge cases where typed
/// properties aren't available or for dynamic CSS generation.
///
/// The `declaration` property is overridden to use the dynamic `name` field
/// instead of the static `property`.
///
/// - Note: Prefer using typed properties when available for better type safety.
///   This type is intended for dynamic or uncommon CSS properties.
public struct StringProperty: W3C_CSS_Shared.Property {
    public static var property: String { "" }

    public let name: String
    public let value: String

    @inlinable
    public init(_ name: String, _ value: String) {
        self.name = name
        self.value = value
    }

    @inlinable
    public static func global(_ global: Global) -> StringProperty {
        StringProperty("", global.rawValue)
    }

    /// Returns just the value, since `Declaration.init` adds the property name
    @inlinable
    public var description: String {
        value
    }

    /// Custom declaration that uses our dynamic name instead of the static property
    @inlinable
    public var declaration: Declaration {
        Declaration(description: "\(name):\(value)")
    }
}
