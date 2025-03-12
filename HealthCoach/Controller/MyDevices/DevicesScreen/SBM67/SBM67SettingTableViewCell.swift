//
//  SBM67SettingTableViewCell.swift
//  HealthCoach
//
//  Created by Keval Thumar on 05/03/25.
//

import UIKit

class SBM67SettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var onTapOut: UIButton!
    
    var isChecked: Bool = false {
        didSet {
            updateCheckboxState()
        }
    }
    
    var checkboxTapped: (() -> Void)?  // ✅ Closure to notify selection change
    
    @IBAction func onTapBtn(_ sender: UIButton) {
        isChecked.toggle()
        checkboxTapped?()
    }
    
    private func updateCheckboxState() {
        let imageName = isChecked ? "checkmark.square.fill" : "square"
        let image = UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(scale: .medium))  // ✅ Medium scale
        onTapOut.setImage(image, for: .normal)
    }
}
