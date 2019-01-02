//
//  CALayer.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 9/8/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import UIKit

public extension CAShapeLayer {
    public convenience init(_ path: UIBezierPath, fillColor: UIColor) {
        self.init()
        self.path = path.cgPath
        self.fillColor = fillColor.cgColor
    }
}
