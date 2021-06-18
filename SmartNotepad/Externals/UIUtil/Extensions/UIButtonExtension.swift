//
//  UIButtonExtension.swift
//  Medical-App
//
//  Created by Hadeer Kamel on 1/10/21.
//

import UIKit
extension UIButton {
    func underLinedTitle(title: String) {
        let yourAttributes: [NSAttributedString.Key: Any] = [
              .underlineStyle: NSUnderlineStyle.single.rawValue]

        let attributeString = NSMutableAttributedString(string: title,
                                                             attributes: yourAttributes)
             self.setAttributedTitle(attributeString, for: .normal)
    }
}
