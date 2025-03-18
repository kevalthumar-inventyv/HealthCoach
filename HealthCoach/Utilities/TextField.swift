//
//  TextField.swift
//  HealthCoach
//
//  Created by Keval Thumar on 18/03/25.
//

import UIKit

@IBDesignable
class UnderlinedTextField: UITextField {
    
    @IBInspectable var underlineColor: UIColor = .gray {
        didSet {
            updateUnderline()
        }
    }
    
    @IBInspectable var underlineHeight: CGFloat = 0.5 {
        didSet {
            updateUnderline()
        }
    }
    
    private let underlineLayer = CALayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUnderline()
    }
    
    private func updateUnderline() {
        underlineLayer.removeFromSuperlayer()  // Remove existing layer to avoid duplicates
        underlineLayer.frame = CGRect(
            x: 0, y: bounds.height - underlineHeight, width: bounds.width,
            height: underlineHeight)
        underlineLayer.backgroundColor = underlineColor.cgColor
        layer.addSublayer(underlineLayer)
    }
    
}
