//
//  SAS75TableViewCell.swift
//  HealthCoach
//
//  Created by Keval Thumar on 05/03/25.
//

import UIKit

class SAS75TableViewCell: UITableViewCell {

    @IBOutlet weak var textField: ReadOnlyTextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var switchOut: UISwitch!
    
    @IBAction func switchBtn(_ sender: UISwitch) {
        parentViewController?.isSwitchOn = sender.isOn
    }
    
    var pickerType: PickerType?
    weak var parentViewController: SAS75ViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        textField.addTarget(self, action: #selector(showPicker), for: .allTouchEvents)
        textField.tintColor = .clear // Hides the cursor
    }

    @objc func showPicker() {
        guard let type = pickerType, let parentVC = parentViewController else {
            print("⚠️ PickerType or ParentViewController is nil")
            return
        }
        
        print("📌 Tapped on text field: \(label.text ?? "Unknown Field")") // 🔥 Debug print

        parentVC.pickerManager.showPicker(for: type, in: parentVC)
    }
}
