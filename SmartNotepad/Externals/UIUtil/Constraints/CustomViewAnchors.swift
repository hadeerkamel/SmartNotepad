//
//  CustomViewAnchors.swift
//  Medical-App
//
//  Created by Hadeer Kamel on 1/7/21.
//
//
//  ViewAnchors.swift
//
//  Created by Hossam Ahmed on 6/17/19.
//  Copyright © 2019 Codesroots. All rights reserved.
//

import UIKit
struct WidthAncohr {
    var width :NSLayoutDimension
    var multiplier : CGFloat?
}
struct HeightAncohr {
    var height :NSLayoutDimension
    var multiplier : CGFloat?
}
extension UIView {

    func removeAllConstraints() {
        var _superview = self.superview

        while let superview = _superview {
            for constraint in superview.constraints {

                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }

            _superview = superview.superview
        }

        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }

    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }

    func anchorSize(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }

    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil,left: NSLayoutXAxisAnchor? = nil , right: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero,positionX:NSLayoutXAxisAnchor? = nil,positionY:NSLayoutYAxisAnchor? = nil,width:WidthAncohr? = nil,height:HeightAncohr? = nil) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -padding.right).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalTo: width.width,multiplier:width.multiplier!).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalTo: height.height,multiplier:height.multiplier!).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        if let positionY = positionY {
            centerYAnchor.constraint(equalTo: positionY).isActive = true
        }
        if let positionX = positionX {
            centerXAnchor.constraint(equalTo: positionX).isActive = true
        }
    }
}
