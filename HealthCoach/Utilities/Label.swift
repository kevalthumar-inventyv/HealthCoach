//
//  Label.swift
//  HealthCoach
//
//  Created by Keval Thumar on 18/03/25.
//

import UIKit

@IBDesignable
class Label: UILabel {

    @IBInspectable var isUnderlined: Bool = false {
        didSet {
            updateUnderline()
        }
    }
    
    @IBInspectable var isBold: Bool = false {
            didSet {
                setBold()
            }
        }

        private func setBold() {
            if isBold {
                self.font = UIFont.boldSystemFont(ofSize: self.font.pointSize)
            } else {
                self.font = UIFont.systemFont(ofSize: self.font.pointSize)
            }
        }
    

    private func updateUnderline() {
        if isUnderlined {
            let attributedString = NSMutableAttributedString(string: self.text ?? "")
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateUnderline()
        setBold()
    }
}

