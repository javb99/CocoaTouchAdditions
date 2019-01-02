//
//  TaggedValue.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 9/24/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import Foundation

public struct Tagged<Tag, Value>: RawRepresentable {
    public let rawValue: Value
    
    public init(rawValue: Value) {
        self.rawValue = rawValue
    }
}

// MARK: - Int Value -

extension Tagged: ExpressibleByIntegerLiteral where Value: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Value.IntegerLiteralType
    
    public init(integerLiteral value: Value.IntegerLiteralType) {
        rawValue = Value.init(integerLiteral: value)
    }
}

// MARK: - Float Value -

extension Tagged: ExpressibleByFloatLiteral where Value: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Value.FloatLiteralType
    
    public init(floatLiteral value: Value.FloatLiteralType) {
        rawValue = Value.init(floatLiteral: value)
    }
}

// MARK: - String Value -

extension Tagged: ExpressibleByUnicodeScalarLiteral where Value: ExpressibleByUnicodeScalarLiteral {
    public typealias UnicodeScalarLiteralType = Value.UnicodeScalarLiteralType
    
    public init(unicodeScalarLiteral value: Value.UnicodeScalarLiteralType) {
        rawValue = Value.init(unicodeScalarLiteral: value)
    }
}

extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral where Value: ExpressibleByExtendedGraphemeClusterLiteral {
    public typealias ExtendedGraphemeClusterLiteralType = Value.ExtendedGraphemeClusterLiteralType
    
    public init(extendedGraphemeClusterLiteral value: Value.ExtendedGraphemeClusterLiteralType) {
        rawValue = Value.init(extendedGraphemeClusterLiteral: value)
    }
}

extension Tagged: ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {
    public typealias StringLiteralType = Value.StringLiteralType
    
    public init(stringLiteral value: Value.StringLiteralType) {
        rawValue = Value.init(stringLiteral: value)
    }
}

// MARK: - Codable -

extension Tagged: Encodable where Value: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        try rawValue.encode(to: encoder)
    }
}

extension Tagged: Decodable where Value: Decodable {
    
    public init(from decoder: Decoder) throws {
        rawValue = try Value.init(from: decoder)
    }
}

// MARK: - Equatable -

extension Tagged: Equatable where Value: Equatable {
    
    public static func == <T, V>(lhs: Tagged<T, V>, rhs: Tagged<T, V>) -> Bool where V: Equatable {
        return lhs.rawValue == rhs.rawValue
    }
}

// MARK: - Hashable -

extension Tagged: Hashable where Value: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        rawValue.hash(into: &hasher)
    }
}

// MARK: - Comparable -

extension Tagged: Comparable where Value: Comparable {
    
    public static func < <T, V>(lhs: Tagged<T, V>, rhs: Tagged<T, V>) -> Bool where V: Comparable {
        return lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Numeric -

extension Tagged: Numeric, SignedNumeric where Value: Numeric {
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        guard let value = Value.init(exactly: source) else {
            return nil
        }
        rawValue = value
    }
    
    public var magnitude: Value.Magnitude {
        return rawValue.magnitude
    }
    
    public static func -= (lhs: inout Tagged<Tag, Value>, rhs: Tagged<Tag, Value>) {
        lhs = lhs - rhs
    }
    
    public static func += <T, V>(lhs: inout Tagged<T, V>, rhs: Tagged<T, V>) where V: Numeric {
        lhs = lhs + rhs
    }
    
    public static func *= <T, V>(lhs: inout Tagged<T, V>, rhs: Tagged<T, V>) where V: Numeric {
        lhs = lhs * rhs
    }
    
    public static func - <T, V>(lhs: Tagged<T, V>, rhs: Tagged<T, V>) -> Tagged<T, V> where V: Numeric {
        return Tagged<T, V>(rawValue: lhs.rawValue - rhs.rawValue)
    }
    
    public static func + <T, V>(lhs: Tagged<T, V>, rhs: Tagged<T, V>) -> Tagged<T, V> where V: Numeric {
        return Tagged<T, V>(rawValue: lhs.rawValue + rhs.rawValue)
    }
    
    public static func * <T, V>(lhs: Tagged<T, V>, rhs: Tagged<T, V>) -> Tagged<T, V> where V: Numeric {
        return Tagged<T, V>(rawValue: lhs.rawValue * rhs.rawValue)
    }
    
    public typealias Magnitude = Value.Magnitude
}
