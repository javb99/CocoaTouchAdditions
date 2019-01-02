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
