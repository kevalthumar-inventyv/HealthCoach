//
//  Utilities.swift
//  HealthCoach
//
//  Created by Keval Thumar on 04/03/25.
//

import UIKit

class Utilities {

    // MARK: - Email Validation (Regex)
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(
            with: email)
    }

    // MARK: - Password Validation (Regex)
    static func isValidPassword(_ password: String) -> Bool {
        let passwordRegex =
            #"^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{12,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(
            with: password)
    }

    // MARK: - Show Reusable Alert
    static func showAlert(
        on viewController: UIViewController, title: String, message: String,
        isSuccess: Bool = false, successAction: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert)
        let actionTitle = isSuccess ? "OK" : "Try Again"
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            if isSuccess { successAction?() }
        }
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }

    // MARK: - Toggle Secure Text Entry (Password Visibility)
    static func toggleEye(for textField: UITextField, sender: UIButton) {
        textField.isSecureTextEntry.toggle()
        let eyeIcon = textField.isSecureTextEntry ? "eye" : "eye.slash"
        let config = UIImage.SymbolConfiguration(scale: .medium)
        let image = UIImage(systemName: eyeIcon, withConfiguration: config)
        sender.setImage(image, for: .normal)
        textField.rightViewMode = .always
        let paddingView = UIView(
            frame: CGRect(x: 0, y: 0, width: 50, height: 35)
        )
        textField.rightView = paddingView
    }
    //    MARK: DatePicker
    static func showDatePicker(
        on viewController: UIViewController,
        completion: @escaping (String) -> Void
    ) {
        let alert = UIAlertController(
            title: "Select Date", message: nil, preferredStyle: .actionSheet)

        let titleFont = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        let attributedTitle = NSAttributedString(
            string: "Select Date", attributes: titleFont)
        alert.setValue(attributedTitle, forKey: "attributedTitle")

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        let maxDate = Calendar.current.date(
            from: DateComponents(year: 2008, month: 12, day: 31))
        datePicker.maximumDate = maxDate

        alert.view.addSubview(datePicker)

        // Increase the alert height to accommodate padding
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true

        let cancelAction = UIAlertAction(
            title: "Cancel", style: .cancel, handler: nil)
        let setAction = UIAlertAction(title: "Set", style: .default) { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"  // Example: 04 Mar 2025
            let selectedDate = formatter.string(from: datePicker.date)
            completion(selectedDate)
        }

        alert.addAction(cancelAction)
        alert.addAction(setAction)

        viewController.present(alert, animated: true)
    }
    // MARK: HeightPicker
    static func showHeightPicker(
        on viewController: UIViewController,
        completion: @escaping (String) -> Void
    ) {
        let alert = UIAlertController(
            title: "Select Height", message: nil, preferredStyle: .actionSheet)
        let titleFont = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        let attributedTitle = NSAttributedString(
            string: "Select Height", attributes: titleFont)
        alert.setValue(attributedTitle, forKey: "attributedTitle")
        let pickerView = UIPickerView(
            frame: CGRect(
                x: 0, y: 20, width: viewController.view.frame.width, height: 200)
        )
        let heightPickerDelegate = HeightPickerDelegate { selectedHeight in
            completion(selectedHeight)
        }

        pickerView.dataSource = heightPickerDelegate
        pickerView.delegate = heightPickerDelegate

        alert.view.addSubview(pickerView)
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true

        // **Set default selection**
        heightPickerDelegate.setDefaultSelection(for: pickerView)

        let cancelAction = UIAlertAction(
            title: "Cancel", style: .cancel, handler: nil)
        let setAction = UIAlertAction(title: "Set", style: .default) { _ in
            completion(heightPickerDelegate.selectedHeight)
        }

        alert.addAction(cancelAction)
        alert.addAction(setAction)

        viewController.present(alert, animated: true)
    }

    // MARK: - HeightPickerDelegate
    class HeightPickerDelegate: NSObject, UIPickerViewDelegate,
        UIPickerViewDataSource
    {

        let units = ["CM", "Feet"]
        let cmValues = Array(120...200)
        let feetValues = Array(3...7)
        let inchValues = Array(0...11)

        var selectedUnit: String = "CM"
        var selectedCm: Int = 176  // Default to 176 cm
        var selectedFeet: Int = 5  // Default to 5'
        var selectedInch: Int = 7  // Default to 7"

        var selectedHeight: String {
            return selectedUnit == "CM"
                ? "\(selectedCm) cm" : "\(selectedFeet)'\(selectedInch)\""
        }

        private var selectionHandler: (String) -> Void
        
        init(selectionHandler: @escaping (String) -> Void) {
            self.selectionHandler = selectionHandler
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            let totalWidth = pickerView.frame.width

            if selectedUnit == "CM" {
                switch component {
                case 0: return totalWidth * 0.2  // 20% for Unit selector
                case 1: return totalWidth * 0.8  // 80% for CM values
                default: return totalWidth * 0.01  // Minimal width for non-used components
                }
            } else { // Feet/Inches Mode
                switch component {
                case 0: return totalWidth * 0.2  // 20% for Unit selector
                case 1: return totalWidth * 0.4  // 40% for Feet
                case 2: return totalWidth * 0.4  // 40% for Inches
                default: return totalWidth * 0.01
                }
            }
        }

        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return selectedUnit == "CM" ? 2 : 3
        }

        func pickerView(
            _ pickerView: UIPickerView, numberOfRowsInComponent component: Int
        ) -> Int {
            switch component {
            case 0: return units.count  // "CM" or "Feet"
            case 1:
                return selectedUnit == "CM"
                    ? cmValues.count : feetValues.count  // cm or feet values
            case 2: return selectedUnit == "Feet" ? inchValues.count : 0  // inch values (only for Feet)
            default: return 0
            }
        }

        func pickerView(
            _ pickerView: UIPickerView, titleForRow row: Int,
            forComponent component: Int
        ) -> String? {
            switch component {
            case 0: return units[row]  // "CM" or "Feet"
            case 1:
                return selectedUnit == "CM"
                    ? "\(cmValues[row]) cm" : "\(feetValues[row])'"
            case 2: return "\(inchValues[row])\""
            default: return nil
            }
        }

        func pickerView(
            _ pickerView: UIPickerView, didSelectRow row: Int,
            inComponent component: Int
        ) {
            switch component {
            case 0:  // Unit changed
                let newUnit = units[row]
                if newUnit != selectedUnit {
                    selectedUnit = newUnit
                    if selectedUnit == "Feet" {
                        convertCmToFeetInches()
                    } else {
                        convertFeetInchesToCm()
                    }
                    pickerView.reloadAllComponents()
                    setDefaultSelection(for: pickerView)
                }
            case 1:
                if selectedUnit == "CM" {
                    selectedCm = cmValues[row]
                } else {
                    selectedFeet = feetValues[row]
                }
            case 2:
                selectedInch = inchValues[row]
            default:
                break
            }
        }

        // MARK: - Default Selection Logic
        func setDefaultSelection(for pickerView: UIPickerView) {
            // Select default unit
            pickerView.selectRow(
                units.firstIndex(of: selectedUnit) ?? 0, inComponent: 0,
                animated: false)

            if selectedUnit == "CM" {
                if let cmIndex = cmValues.firstIndex(of: selectedCm) {
                    pickerView.selectRow(
                        cmIndex, inComponent: 1, animated: false)
                }
            } else {
                if let feetIndex = feetValues.firstIndex(of: selectedFeet) {
                    pickerView.selectRow(
                        feetIndex, inComponent: 1, animated: false)
                }
                if let inchIndex = inchValues.firstIndex(of: selectedInch) {
                    pickerView.selectRow(
                        inchIndex, inComponent: 2, animated: false)
                }
            }
        }

        // MARK: - Conversion Logic
        func convertCmToFeetInches() {
            let totalInches = Double(selectedCm) / 2.54
            selectedFeet = Int(totalInches) / 12  // Get whole feet
            selectedInch = Int(totalInches) % 12  // Get remaining inches
        }


        func convertFeetInchesToCm() {
            let totalInches = (selectedFeet * 12) + selectedInch
            let cmValue = Double(totalInches) * 2.54
            selectedCm = Int(cmValue) // Convert to integer CM value
        }

    }

}
