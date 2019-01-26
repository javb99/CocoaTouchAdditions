//
//  UICollectionView.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 1/22/19.
//  Copyright © 2019 Joseph Van Boxtel. All rights reserved.
//

import UIKit

extension UICollectionView {
    /// Sets the color on the backgroundView creating it if needed.
    public func setBackgroundColor(_ color: UIColor) {
        if backgroundView == nil {
            // Create a simple UIView if there is one already.
            let bgView = UIView()
            bgView.frame = bounds
            backgroundView = bgView
            bgView.usesAutoLayout()
            bgView.constrain(to: self)
        }
        
        backgroundView!.backgroundColor = color
    }
    
    /// Wether the index path is contained in indexPathsForSelectedItems.
    public func isItemSelected(at indexPath: IndexPath) -> Bool {
        return indexPathsForSelectedItems?.contains(indexPath) ?? false
    }
}
