//
//  UIVIew+Constraints.swift
//  CSMovies
//
//  Created by Amanda Calcic on 17/11/22.
//

import UIKit

public extension UIView {
    typealias LayoutXAnchorConstant = (anchor: NSLayoutXAxisAnchor, constant: CGFloat)
    typealias LayoutYAnchorConstant = (anchor: NSLayoutYAxisAnchor, constant: CGFloat)
    
    struct Constraints {
        public var centerX: NSLayoutConstraint? { didSet { centerX?.isActive = true } }
        public var centerY: NSLayoutConstraint? { didSet {centerY?.isActive = true } }
        public var top: NSLayoutConstraint? { didSet { top?.isActive = true } }
        public var left: NSLayoutConstraint? { didSet { left?.isActive = true } }
        public var right: NSLayoutConstraint? { didSet { right?.isActive = true } }
        public var leading: NSLayoutConstraint? { didSet { leading?.isActive = true } }
        public var trailing: NSLayoutConstraint? { didSet { trailing?.isActive = true } }
        public var bottom: NSLayoutConstraint? { didSet { bottom?.isActive = true } }
        public var width: NSLayoutConstraint? { didSet { width?.isActive = true} }
        public var height: NSLayoutConstraint? { didSet {height?.isActive = true} }
    }
    
    func setupAnchor(centerX: LayoutXAnchorConstant? = nil,
                     centerY: LayoutYAnchorConstant? = nil,
                     top: LayoutYAnchorConstant? = nil,
                     left: LayoutXAnchorConstant? = nil,
                     right: LayoutXAnchorConstant? = nil,
                     leading: LayoutXAnchorConstant? = nil,
                     trailing: LayoutXAnchorConstant? = nil,
                     bottom: LayoutYAnchorConstant? = nil,
                     width: CGFloat? = nil,
                     height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = Constraints()
        
        if let centerX = centerX { constraints.centerX = centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.constant) }
        if let centerY = centerY { constraints.centerY = centerYAnchor.constraint(equalTo: centerY.anchor, constant: centerY.constant) }
        
        if let top = top { constraints.top = topAnchor.constraint(equalTo: top.anchor, constant: top.constant) }
        if let left = left { constraints.left = leftAnchor.constraint(equalTo: left.anchor, constant: left.constant) }
        if let right = right { constraints.right = rightAnchor.constraint(equalTo: right.anchor, constant: -right.constant) }
        if let leading = leading { constraints.left = leadingAnchor.constraint(equalTo: leading.anchor, constant: leading.constant) }
        if let trailing = trailing { constraints.right = trailingAnchor.constraint(equalTo: trailing.anchor, constant: -trailing.constant) }
        if let bottom = bottom {  constraints.bottom = bottomAnchor.constraint(equalTo: bottom.anchor, constant: -bottom.constant) }
        
        if let width = width { constraints.width = widthAnchor.constraint(equalToConstant: width) }
        if let height = height { constraints.height = heightAnchor.constraint(equalToConstant: height) }
    }
}
