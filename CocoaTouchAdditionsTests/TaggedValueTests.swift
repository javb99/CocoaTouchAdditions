//
//  TaggedValueTests.swift
//  CocoaTouchAdditionsTests
//
//  Created by Joseph Van Boxtel on 9/24/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import XCTest
@testable import CocoaTouchAdditions

enum _TableViewCellIdentifierTag {}
typealias TableViewCellIdentifier = Tagged<_TableViewCellIdentifierTag, String>

extension Tagged where Tag == _TableViewCellIdentifierTag, Value == String {
    func someFunction() {}
}

enum _CelsiusTag {}
typealias Celsius = Tagged<_CelsiusTag, Double>
enum _FahrenheitTag {}
typealias Fahrenheit = Tagged<_FahrenheitTag, Double>

extension Tagged where Tag == _CelsiusTag, RawValue == Double {
    var fahrenheit: Fahrenheit {
        return .init(rawValue: self.rawValue / 5 * 9 + 32.0)
    }
}

extension Tagged where Tag == _FahrenheitTag, RawValue == Double {
    var celcius: Celsius {
        return .init(rawValue: (self.rawValue - 32) / 9 * 5)
    }
}

class TaggedValuesTestsTests: XCTestCase {
    
    func testStringValue() {
        var identifier: TableViewCellIdentifier
        identifier = "Hello"
        func needsString(_ string: String) {}
        needsString(identifier.rawValue)
        
        func needsIdentifer(_ identifier: TableViewCellIdentifier) {}
        needsIdentifer("Hello Tagging World.")
    }
    
    func testIntValue() {
        let temp: Fahrenheit = 32.0
        temp.celcius
    }
    
}
