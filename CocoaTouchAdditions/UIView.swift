//
//  UIView.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 9/8/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import UIKit

public func viewToRep(_ layer: CALayer) -> UIView {
    let view = UIView(frame: layer.frame)
    view.layer.addSublayer(layer)
    return view
}

public extension UIView {
    public func corners(ofRadius radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    public func maskToCorners() {
        layer.masksToBounds = true
    }
    
    public func maskToCorners(ofRadius radius: CGFloat) {
        layer.masksToBounds = true
        corners(ofRadius: radius)
    }
    
    public func border(of color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    public func circleCorners() {
        let diameter = min(bounds.width, bounds.height)
        corners(ofRadius: diameter/2)
    }
}

public extension UIView {
    public func usesAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Activates the constraints and signals the use of auto layout.
    public func use(_ constraints: [NSLayoutConstraint]) {
        usesAutoLayout()
        NSLayoutConstraint.activate(constraints)
    }
    
    public func constrain(to view: UIView) {
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    /// Changes the zPosition to be above the section headers of CollectionViewFlowLayout.
    public func positionAboveSectionHeaders() {
        layer.zPosition = max(layer.zPosition, 2)
    }
}

public extension UIImageView {
    public func circleBordered(by color: UIColor, width: CGFloat) {
        circleCorners()
        maskToCorners()
        border(of: color, width: width)
    }
}

public extension UIButton {
    public func roundedAndInset() {
        contentEdgeInsets = .init(top: 8, left: 12, bottom: 8, right: 12)
        corners(ofRadius: 8)
    }
}

public extension UIBezierPath {
    public convenience init(sliceNumber: Int, of totalSlices: Int, radius: CGFloat, center: CGPoint, offsetByRadians: CGFloat = 0) {
        let radiansPerSlice = -2*CGFloat.pi / CGFloat(totalSlices)
        let start = CGFloat(sliceNumber) * radiansPerSlice + offsetByRadians
        let end = start + radiansPerSlice
        self.init()
        move(to: center)
        let startPt = CGPoint(x: center.x + cos(start)*radius, y: center.y + sin(start)*radius)
        addLine(to: startPt)
        addArc(withCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: false)
        addLine(to: center)
    }
}
