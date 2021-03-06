//
//  Collection.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 10/26/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import Foundation

extension Collection where Element: Equatable {
    public func intersection(_ other: Self) -> [Element] {
        return self.filter { other.contains($0) }
    }
}

extension Array where Element: Equatable {
    /// Complexity: O(n)
    public func does(_ a: Element, appearBefore b: Element) -> Bool {
        for element in self {
            if element == a {
                return true
            } else if element == b {
                return false
            }
        }
        assertionFailure("Neither element is contained.")
        return false
    }
}
