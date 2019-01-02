//
//  GradientView.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 9/21/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import UIKit

public class AxialGradientView: UIView {
    
    public var colors: [UIColor] = [] {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
        }
    }
    
    /// Expressed in a unit coordinate system.
    public var startPoint: CGPoint = .unitCenterTop {
        didSet {
            gradientLayer.startPoint = startPoint
        }
    }
    
    /// Expressed in a unit coordinate system.
    public var endPoint: CGPoint = .unitCenterBottom {
        didSet {
            gradientLayer.endPoint = endPoint
        }
    }
    
    override public class var layerClass: Swift.AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
}
