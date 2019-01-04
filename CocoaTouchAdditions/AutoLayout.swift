//
//  AutoLayout.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 1/3/19.
//  Copyright © 2019 Joseph Van Boxtel. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// Opts the view in to autolayout.
    public func usesAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Activates the constraints and signals the use of auto layout.
    public func activate(_ constraints: [NSLayoutConstraint]) {
        usesAutoLayout()
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Creates and activates constraints for the top, leading, trailing, and bottom anchors of self to the corrosponding anchor on `view`. The insets's left corrosponds the the leadingAnchor and the right corrosponds to the trailingAnchor. Returns the active constraints.
    @discardableResult
    public func constrain(to referenceView: UIView, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        let constraints: [NSLayoutConstraint] = [
            self.constrain(\UIView.topAnchor, to: referenceView, constant: insets.top),
            self.constrain(\UIView.leadingAnchor, to: referenceView, constant: insets.left),
            self.constrain(\UIView.trailingAnchor, to: referenceView, constant: insets.right),
            self.constrain(\UIView.bottomAnchor, to: referenceView, constant: insets.bottom)
        ]
        return constraints
    }
    
    /// Constrains the given anchor on self to the same anchor on referenceView with the given constant or zero. Returns the active constraint.
    @discardableResult
    public func constrain<Axis, Anchor>(_ anchor: KeyPath<UIView, Anchor>, to referenceView: UIView, constant: CGFloat = 0) -> NSLayoutConstraint  where Anchor: NSLayoutAnchor<Axis> {
        let const = self[keyPath: anchor].constraint(equalTo: referenceView[keyPath: anchor], constant: constant)
        const.isActive = true
        return const
    }
}
