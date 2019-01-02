//
//  Transform.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 11/19/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import Foundation

public struct Transform<A, B> {
    public let apply: (A)->(B)
    public let undo: (B)->(A)
    
    public init(apply: @escaping (A)->(B), undo: @escaping (B)->(A)) {
        self.apply = apply
        self.undo = undo
    }
}

extension Transform where A == B {
    public static var identity: Transform<A, A> {
        return Transform<A, A>(apply: { return $0 }, undo: { return $0 })
    }
}
