//
//  UIColor.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 9/9/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /// Returns a brighter color by increasing brightnesss, and decreasing saturation.
    func brighter(by brightnessFactor: CGFloat) -> UIColor? {
        print("Brightening by \(brightnessFactor*100)%")
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        guard getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else {
            print("Could not convert to HSB color space.")
            return nil
        }
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness * (1 + brightnessFactor), alpha: alpha)
    }
}

extension UIColor {
    // Overlays the given color above self and blends using their alpha values.
    public func overlay(_ overlayColor: UIColor) -> UIColor {
        var bgR: CGFloat = 0
        var bgG: CGFloat = 0
        var bgB: CGFloat = 0
        var bgA: CGFloat = 0
        self.getRed(&bgR, green: &bgG, blue: &bgB, alpha: &bgA)
        var ovR: CGFloat = 0
        var ovG: CGFloat = 0
        var ovB: CGFloat = 0
        var ovA: CGFloat = 0
        overlayColor.getRed(&ovR, green: &ovG, blue: &ovB, alpha: &ovA)
        return UIColor(red:   ovR*ovA  + (bgR*bgA) * (1-ovA),
                       green: ovG*ovA  + (bgG*bgA) * (1-ovA),
                       blue:  ovB*ovA  + (bgB*bgA) * (1-ovA),
                       alpha: bgA + ovA)
    }
}
