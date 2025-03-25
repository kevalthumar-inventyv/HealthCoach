//
//  Utilities.swift
//  HealthCoach
//
//  Created by Keval Thumar on 04/03/25.
//

import UIKit

class Utilities {



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
        let eyeIcon = textField.isSecureTextEntry ? "eye.slash" : "eye"
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

    
    // MARK: ActivityPicker
    static func showActivityPicker(
        on viewController: UIViewController,
        completion: @escaping (String) -> Void
    ) {
        let alert = UIAlertController(
            title: "Select Activity", message: nil, preferredStyle: .actionSheet)
        
        let titleFont = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        let attributedTitle = NSAttributedString(
            string: "Select Activity", attributes: titleFont)
        alert.setValue(attributedTitle, forKey: "attributedTitle")

        let pickerView = UIPickerView(
            frame: CGRect(x: 0, y: 20, width: viewController.view.frame.width, height: 200)
        )
        
        let activityPickerDelegate = ActivityPickerDelegate { selectedActivity in
            completion(selectedActivity)
        }

        pickerView.dataSource = activityPickerDelegate
        pickerView.delegate = activityPickerDelegate

        alert.view.addSubview(pickerView)
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true

        // **Set default selection**
        activityPickerDelegate.setDefaultSelection(for: pickerView)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let setAction = UIAlertAction(title: "Set", style: .default) { _ in
            completion(activityPickerDelegate.selectedActivity)
        }

        alert.addAction(cancelAction)
        alert.addAction(setAction)

        viewController.present(alert, animated: true)
    }

    // MARK: - ActivityPickerDelegate
    class ActivityPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        let activityTypes = ["Steps", "Calories"]
        let stepsValues = Array(stride(from: 1000, through: 20000, by: 1000))  // 1000 to 20000
        let caloriesValues = Array(stride(from: 500, through: 10000, by: 500)) // 500 to 10000

        var selectedActivityType: String = "Steps"
        var selectedSteps: Int = 10000  // Default Steps: 10,000
        var selectedCalories: Int = 500  // Default Calories: 500

        var selectedActivity: String {
            return selectedActivityType == "Steps"
                ? "\(selectedSteps) Steps" : "\(selectedCalories) Calories"
        }

        private var selectionHandler: (String) -> Void
        
        init(selectionHandler: @escaping (String) -> Void) {
            self.selectionHandler = selectionHandler
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
            case 0: return activityTypes.count  // "Steps" or "Calories"
            case 1:
                return selectedActivityType == "Steps"
                    ? stepsValues.count : caloriesValues.count
            default: return 0
            }
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch component {
            case 0: return activityTypes[row]  // "Steps" or "Calories"
            case 1:
                return selectedActivityType == "Steps"
                    ? "\(stepsValues[row])" : "\(caloriesValues[row])"
            default: return nil
            }
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch component {
            case 0:  // Activity Type changed
                let newActivityType = activityTypes[row]
                if newActivityType != selectedActivityType {
                    selectedActivityType = newActivityType
                    pickerView.reloadComponent(1)
                    setDefaultSelection(for: pickerView)
                }
            case 1:
                if selectedActivityType == "Steps" {
                    selectedSteps = stepsValues[row]
                } else {
                    selectedCalories = caloriesValues[row]
                }
            default:
                break
            }
        }

        // MARK: - Default Selection Logic
        func setDefaultSelection(for pickerView: UIPickerView) {
            pickerView.selectRow(activityTypes.firstIndex(of: selectedActivityType) ?? 0, inComponent: 0, animated: false)

            if selectedActivityType == "Steps" {
                if let stepIndex = stepsValues.firstIndex(of: selectedSteps) {
                    pickerView.selectRow(stepIndex, inComponent: 1, animated: false)
                }
            } else {
                if let calorieIndex = caloriesValues.firstIndex(of: selectedCalories) {
                    pickerView.selectRow(calorieIndex, inComponent: 1, animated: false)
                }
            }
        }
    }

    
    // MARK: AlarmPicker
    static func showAlarmPicker(
        on viewController: UIViewController,
        completion: @escaping (String) -> Void
    ) {
        let alert = UIAlertController(
            title: "Select Alarm Time", message: nil, preferredStyle: .actionSheet)
        
        let titleFont = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        let attributedTitle = NSAttributedString(
            string: "Select Alarm Time", attributes: titleFont)
        alert.setValue(attributedTitle, forKey: "attributedTitle")

        let pickerView = UIPickerView(
            frame: CGRect(x: 0, y: 20, width: viewController.view.frame.width, height: 200)
        )
        
        let AlarmPickerDelegate = AlarmPickerDelegate { selectedAlarmTime in
            completion(selectedAlarmTime)
        }

        pickerView.dataSource = AlarmPickerDelegate
        pickerView.delegate = AlarmPickerDelegate

        alert.view.addSubview(pickerView)
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true

        // **Set default selection**
        AlarmPickerDelegate.setDefaultSelection(for: pickerView)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let setAction = UIAlertAction(title: "Set", style: .default) { _ in
            completion(AlarmPickerDelegate.selectedAlarmTime)
        }

        alert.addAction(cancelAction)
        alert.addAction(setAction)

        viewController.present(alert, animated: true)
    }

    // MARK: - AlarmPickerDelegate
    class AlarmPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

        let hours = Array(0...12)
        let minutes = Array(0...59)
        let amPmValues = ["AM", "PM"]

        var selectedHour: Int = 8   // Default: 8 Hours
        var selectedMinute: Int = 0  // Default: 00 Minutes
        var selectedAmPm: String = "AM"  // Default: AM

        var selectedAlarmTime: String {
            return String(format: "%02d:%02d %@", selectedHour, selectedMinute, selectedAmPm)
        }

        private var selectionHandler: (String) -> Void
        
        init(selectionHandler: @escaping (String) -> Void) {
            self.selectionHandler = selectionHandler
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 3  // Hours, Minutes, AM/PM
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
            case 0: return hours.count
            case 1: return minutes.count
            case 2: return amPmValues.count
            default: return 0
            }
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch component {
            case 0: return "\(hours[row]) hr"
            case 1: return String(format: "%02d min", minutes[row])
            case 2: return amPmValues[row]
            default: return nil
            }
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch component {
            case 0: selectedHour = hours[row]
            case 1: selectedMinute = minutes[row]
            case 2: selectedAmPm = amPmValues[row]
            default: break
            }
        }

        // MARK: - Default Selection Logic
        func setDefaultSelection(for pickerView: UIPickerView) {
            pickerView.selectRow(hours.firstIndex(of: selectedHour) ?? 0, inComponent: 0, animated: false)
            pickerView.selectRow(minutes.firstIndex(of: selectedMinute) ?? 0, inComponent: 1, animated: false)
            pickerView.selectRow(amPmValues.firstIndex(of: selectedAmPm) ?? 0, inComponent: 2, animated: false)
        }
    }

    // MARK: Target Sleep Picker
    static func showTargetSleepPicker(
        on viewController: UIViewController,
        completion: @escaping (String) -> Void
    ) {
        let alert = UIAlertController(title: "Select Sleep Duration", message: nil, preferredStyle: .actionSheet)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 20, width: viewController.view.frame.width, height: 200))
        let pickerDelegate = TargetSleepPickerDelegate { selectedSleep in
            completion(selectedSleep)
        }
        
        pickerView.dataSource = pickerDelegate
        pickerView.delegate = pickerDelegate
        
        alert.view.addSubview(pickerView)
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        pickerDelegate.setDefaultSelection(for: pickerView)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let setAction = UIAlertAction(title: "Set", style: .default) { _ in
            completion(pickerDelegate.selectedSleep)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(setAction)
        
        viewController.present(alert, animated: true)
    }

    // MARK: - TargetSleepPickerDelegate
    class TargetSleepPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        let hours = (0...23).map { "\($0) hr" }
        let minutes = (0...59).map { "\($0) min" }
        
        var selectedHour: String = "08 hr"
        var selectedMinute: String = "00 min"
        
        var selectedSleep: String {
            return "\(selectedHour) \(selectedMinute)"
        }
        
        private var selectionHandler: (String) -> Void
        
        init(selectionHandler: @escaping (String) -> Void) {
            self.selectionHandler = selectionHandler
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int { return 2 }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return component == 0 ? hours.count : minutes.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return component == 0 ? hours[row] : minutes[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
                selectedHour = hours[row]
            } else {
                selectedMinute = minutes[row]
            }
        }
        
        func setDefaultSelection(for pickerView: UIPickerView) {
            pickerView.selectRow(8, inComponent: 0, animated: false)  // Default: 08 hr
            pickerView.selectRow(0, inComponent: 1, animated: false)  // Default: 00 min
        }
    }

    // MARK: Walk Picker
    static func showWalkPicker(
        on viewController: UIViewController,
        completion: @escaping (String) -> Void
    ) {
        let alert = UIAlertController(title: "Select Walk Distance", message: nil, preferredStyle: .actionSheet)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 20, width: viewController.view.frame.width, height: 200))
        let pickerDelegate = WalkPickerDelegate { selectedWalk in
            completion(selectedWalk)
        }
        
        pickerView.dataSource = pickerDelegate
        pickerView.delegate = pickerDelegate
        
        alert.view.addSubview(pickerView)
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        pickerDelegate.setDefaultSelection(for: pickerView)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let setAction = UIAlertAction(title: "Set", style: .default) { _ in
            completion(pickerDelegate.selectedWalk)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(setAction)
        
        viewController.present(alert, animated: true)
    }

    // MARK: - WalkPickerDelegate
    class WalkPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        let feet = (0...8).map { "\($0)'" }
        let inches = (0...11).map { "\($0)\"" }
        
        var selectedFeet: String = "2'"
        var selectedInches: String = "3\""
        
        var selectedWalk: String {
            return "\(selectedFeet) \(selectedInches)"
        }
        
        private var selectionHandler: (String) -> Void
        
        init(selectionHandler: @escaping (String) -> Void) {
            self.selectionHandler = selectionHandler
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int { return 2 }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return component == 0 ? feet.count : inches.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return component == 0 ? feet[row] : inches[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
                selectedFeet = feet[row]
            } else {
                selectedInches = inches[row]
            }
        }
        
        func setDefaultSelection(for pickerView: UIPickerView) {
            pickerView.selectRow(2, inComponent: 0, animated: false)  // Default: 2'
            pickerView.selectRow(3, inComponent: 1, animated: false)  // Default: 3"
        }
    }

    // MARK: Weight Picker with Unit Selection (lb/kg)
    static func showWeightPicker(
        on viewController: UIViewController,
        completion: @escaping (String) -> Void
    ) {
        let alert = UIAlertController(title: "Select Weight", message: nil, preferredStyle: .actionSheet)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 20, width: viewController.view.frame.width, height: 200))
        let pickerDelegate = WeightPickerDelegate { selectedWeight in
            completion(selectedWeight)
        }
        
        pickerView.dataSource = pickerDelegate
        pickerView.delegate = pickerDelegate
        
        alert.view.addSubview(pickerView)
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        pickerDelegate.setDefaultSelection(for: pickerView)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let setAction = UIAlertAction(title: "Set", style: .default) { _ in
            completion(pickerDelegate.selectedWeight)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(setAction)
        
        viewController.present(alert, animated: true)
    }

    // MARK: - WeightPickerDelegate
    class WeightPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        let integerValues = (50...300).map { "\($0)" }  // 50 - 300
        let decimalValues = (0...9).map { "\($0)" }     // 0 - 9
        let weightUnits = ["lb", "kg"]                 // lb or kg
        
        var selectedInteger: String = "154"
        var selectedDecimal: String = "3"
        var selectedUnit: String = "lb"
        
        var selectedWeight: String {
            return "\(selectedInteger).\(selectedDecimal) \(selectedUnit)"
        }
        
        private var selectionHandler: (String) -> Void
        
        init(selectionHandler: @escaping (String) -> Void) {
            self.selectionHandler = selectionHandler
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int { return 3 }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
            case 0: return integerValues.count
            case 1: return decimalValues.count
            case 2: return weightUnits.count
            default: return 0
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch component {
            case 0: return integerValues[row]
            case 1: return decimalValues[row]
            case 2: return weightUnits[row]
            default: return nil
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch component {
            case 0: selectedInteger = integerValues[row]
            case 1: selectedDecimal = decimalValues[row]
            case 2: selectedUnit = weightUnits[row]
            default: break
            }
        }
        
        func setDefaultSelection(for pickerView: UIPickerView) {
            pickerView.selectRow(104, inComponent: 0, animated: false)  // Default: 154
            pickerView.selectRow(3, inComponent: 1, animated: false)   // Default: .3
            pickerView.selectRow(0, inComponent: 2, animated: false)   // Default: lb
        }
    }

}
