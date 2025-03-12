//
//  PickerManager.swift
//  HealthCoach
//
//  Created by Keval Thumar on 05/03/25.
//
import UIKit

protocol PickerManagerDelegate: AnyObject {
    func didPickValue(_ value: String, for type: PickerType)
}

enum PickerType {
    case targetActivity  // 2 columns: (1) Unit selection (2) Values change dynamically
    case targetSleep     // 2 columns: Hours & Minutes
    case walk            // 2 columns: Feet & Inches
    case weight          // 2 columns: Integer & Decimal
    case alarmTime       // 3 columns: AM/PM, Hours, Minutes

    var numberOfComponents: Int {
        switch self {
        case .targetActivity, .targetSleep, .walk, .weight:
            return 2
        case .alarmTime:
            return 3
        }
    }
}

class PickerManager: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

    weak var delegate: PickerManagerDelegate?
    private var pickerType: PickerType = .targetActivity
    private var pickerData: [[String]] = []
    private var selectedValues: [String] = []  // ✅ Ensure proper initialization

    func showPicker(for type: PickerType, in viewController: UIViewController) {
        self.pickerType = type
        configurePickerData()
        
        let alert = UIAlertController(title: "Select \(type)", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        let titleFont = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        _ = NSAttributedString(
            string: "Select \(type)", attributes: titleFont)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 30, width: viewController.view.frame.width - 20, height: 200))
        pickerView.delegate = self
        pickerView.dataSource = self
        alert.view.addSubview(pickerView)
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            if self.selectedValues.count == self.pickerData.count {
                let finalValue = self.formatFinalValue()
                self.delegate?.didPickValue(finalValue, for: self.pickerType)
            } else {
                print("⚠️ Error: selectedValues count mismatch. Expected \(self.pickerData.count), got \(self.selectedValues.count)")
            }
        }
        
        alert.addAction(doneAction)
        viewController.present(alert, animated: true)
    }
    
    private func configurePickerData() {
        switch pickerType {
        case .targetActivity:
            pickerData = [
                ["Calories", "Steps"],  // First column: Unit Type
                (100...3000).filter { $0 % 100 == 0 }.map { "\($0)" }  // Default: Calories
            ]
            selectedValues = ["Calories", "500"]  // ✅ Default selection

        case .targetSleep:
            pickerData = [(0...24).map { "\($0)" }, (0...59).map { "\($0)" }]
            selectedValues = ["08", "00"]  // Default: "08:00 Hours"

        case .walk:
            pickerData = [(0...8).map { "\($0)'" }, (0...11).map { "\($0)\"" }]
            selectedValues = ["2'", "3\""]  // Default: "2' 3\""

        case .weight:
            pickerData = [(50...300).map { "\($0)" }, (0...9).map { "\($0)" }]
            selectedValues = ["154", "3"]  // Default: "154.3 lb"

        case .alarmTime:
            pickerData = [["AM", "PM"], (1...12).map { "\($0)" }, (0...59).map { "\($0)" }]
            selectedValues = ["AM", "08", "00"]  // Default: "08:00 AM"
        }
    }

    // Format selectedValues to match `textfieldValue` format
    private func formatFinalValue() -> String {
        switch pickerType {
        case .targetActivity:
            return "\(selectedValues[1]) \(selectedValues[0])"  // e.g., "500 Calories" or "5000 Steps"

        case .targetSleep:
            return "\(selectedValues[0]):\(selectedValues[1]) Hours"  // e.g., "08:00 Hours"

        case .walk:
            return "\(selectedValues[0]) \(selectedValues[1])"  // e.g., "2' 3\""

        case .weight:
            return "\(selectedValues[0]).\(selectedValues[1]) lb"  // e.g., "154.3 lb"

        case .alarmTime:
            return "\(selectedValues[1]):\(selectedValues[2]) \(selectedValues[0])"  // e.g., "08:00 AM"
        }
    }

    // MARK: - UIPickerView Data Source & Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerType == .targetActivity {
            if component == 0 { // User switched between "Calories" and "Steps"
                let selectedUnit = pickerData[0][row]
                selectedValues[0] = selectedUnit
                
                if selectedUnit == "Calories" {
                    pickerData[1] = (100...3000).filter { $0 % 100 == 0 }.map { "\($0)" }
                    selectedValues[1] = "500" // Reset to default
                } else {
                    pickerData[1] = (1000...20000).filter { $0 % 1000 == 0 }.map { "\($0)" }
                    selectedValues[1] = "5000" // Reset to default
                }
                
                pickerView.reloadComponent(1) // ✅ Dynamically update the second column
            } else { // User selected a value in the second column
                selectedValues[1] = pickerData[1][row]
            }
        } else {
            if component < selectedValues.count {
                selectedValues[component] = pickerData[component][row]
            } else {
                print("⚠️ Error: selectedValues index out of range for component \(component)")
            }
        }
    }
}
