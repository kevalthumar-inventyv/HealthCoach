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

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUnderline()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateUnderline()
    }

    private func setupUnderline() {
        layer.addSublayer(underlineLayer)
        updateUnderline()
    }

    private func updateUnderline() {
        underlineLayer.frame = CGRect(
            x: 0, y: bounds.height - underlineHeight, width: bounds.width,
            height: underlineHeight)
        underlineLayer.backgroundColor = underlineColor.cgColor
    }
}

class TextFieldNavigationHandler: NSObject, UITextFieldDelegate {
    private var textFields: [UITextField] = []

    init(textFields: [UITextField]) {
        super.init()
        self.textFields = textFields
        assignDelegates()
    }

    private func assignDelegates() {
        for textField in textFields {
            textField.delegate = self
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let currentIndex = textFields.firstIndex(of: textField), currentIndex < textFields.count - 1 {
            textFields[currentIndex + 1].becomeFirstResponder() // Move to next field
        } else {
            textField.resignFirstResponder() // Close keyboard on last field
        }
        return true
    }
}
