//
//  NavigationBarConfiguration.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 11/20/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import UIKit

extension UINavigationBar {
    public func apply(_ config: NavBarConfiguration) {
        if let v = config.barStyle { barStyle = v }
        if let v = config.isTranslucent { isTranslucent = v }
        if let v = config.prefersLargeTitles { prefersLargeTitles = v }
        if let v = config.tintColor { tintColor = v }
        if let v = config.barTintColor { barTintColor = v }
        if let v = config.titleTextAttributes { titleTextAttributes = v }
        if let v = config.largeTitleTextAttributes { largeTitleTextAttributes = v }
        if let v = config.shadowImage { shadowImage = v }
        if let v = config.backgroundImage { setBackgroundImage(v, for: .default)}
    }
    
    public var currentConfig: NavBarConfiguration {
        var config = NavBarConfiguration()
        config.barStyle = barStyle
        config.isTranslucent = isTranslucent
        config.prefersLargeTitles = prefersLargeTitles
        config.tintColor = tintColor
        config.barTintColor = barTintColor
        config.titleTextAttributes = titleTextAttributes
        config.largeTitleTextAttributes = largeTitleTextAttributes
        config.shadowImage = shadowImage
        config.backgroundImage = backgroundImage(for: .default)
        return config
    }
}

/// Leave a field nil to leave it unchanged.
public struct NavBarConfiguration {
    public var barStyle: UIBarStyle? = nil
    public var isTranslucent: Bool? = nil
    public var prefersLargeTitles: Bool? = nil
    public var tintColor: UIColor? = nil
    public var barTintColor: UIColor?? = nil
    
    public var titleTextAttributes: [NSAttributedString.Key : Any]?? = nil
    public var largeTitleTextAttributes: [NSAttributedString.Key : Any]?? = nil
    
    public var shadowImage: UIImage?? = nil
    public var backgroundImage: UIImage?? = nil
    
    public init() {}
}
