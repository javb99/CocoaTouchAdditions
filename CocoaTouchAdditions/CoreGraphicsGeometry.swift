//
//  CoreGraphicsGeometry.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 9/8/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import UIKit

public extension CGPoint {
    public static let unitLeftCenter = CGPoint(x: 0, y: 0.5)
    public static let unitRightCenter = CGPoint(x: 1, y: 0.5)
    public static let unitCenterTop = CGPoint(x: 0.5, y: 0)
    public static let unitCenterBottom = CGPoint(x: 0.5, y: 1)
    public static let unitLeftTop = CGPoint(x: 0, y: 0)
    public static let unitRightTop = CGPoint(x: 1, y: 0)
    public static let unitLeftBottom = CGPoint(x: 0, y: 1)
    public static let unitRightBottom = CGPoint(x: 1, y: 1)
    public static let unitCenter = CGPoint(x: 0.5, y: 0.5)
}

public extension CGRect {
    public var center: CGPoint {
        get {
            return CGPoint(x: origin.x + width/2, y: origin.y + height/2)
        }
        set {
            origin.x = newValue.x - width/2
            origin.y = newValue.y - height/2
        }
    }
    
    public init(squareOfLength length: CGFloat) {
        self.init(x: 0, y: 0, width: length, height: length)
    }
}
