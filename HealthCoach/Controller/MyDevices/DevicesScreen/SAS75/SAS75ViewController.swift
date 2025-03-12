//
//  SAS75ViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 05/03/25.
//

import UIKit

class SAS75ViewController: UIViewController {
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    let settingLabel: [String] = [
        "Target Activity", "Target Sleep", "Walk", "Weight", "Alarm Time"
    ]
    
    var switchStates: [Bool] = [false, false, false, false, true] // Only last row has switch

    var textfieldValue: [String] = ["500 Calories", "08:00 Hours", "2' 3\"", "154.3 lb", "08:00 AM"]
    var isSwitchOn: Bool = false
    
    let pickerManager = PickerManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        pickerManager.delegate = self
    }

    @IBAction func nextBtn(_ sender: UIButton) {
        print("Target Activity: \(textfieldValue[0])")
        print("Target Sleep: \(textfieldValue[1])")
        print("Walk: \(textfieldValue[2])")
        print("Weight: \(textfieldValue[3])")
        print("Alarm Time: \(textfieldValue[4])")
        print("Switch is \(isSwitchOn ? "ON" : "OFF")")
        
        let syncVC = self.storyboard?.instantiateViewController(identifier: "SAS75SynchronizationViewController") as! SAS75SynchronizationViewController
        self.navigationController?.pushViewController(syncVC, animated: true)
    }

    @IBOutlet weak var tableView: UITableView!
}

extension SAS75ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingLabel.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SAS75TableViewCell
        cell.label.text = settingLabel[indexPath.row]
        cell.textField.text = textfieldValue[indexPath.row]

        cell.pickerType = [
            .targetActivity, .targetSleep, .walk, .weight, .alarmTime
        ][indexPath.row]

        cell.parentViewController = self
        cell.textField.inputView = UIView() // Prevent keyboard from appearing
        cell.switchOut.isHidden = !switchStates[indexPath.row]
        cell.switchOut.isOn = isSwitchOn
        return cell
    }
}

extension SAS75ViewController: PickerManagerDelegate {
    func didPickValue(_ value: String, for type: PickerType) {
        switch type {
        case .targetActivity:
            textfieldValue[0] = value
        case .targetSleep:
            textfieldValue[1] = value
        case .walk:
            textfieldValue[2] = value
        case .weight:
            textfieldValue[3] = value
        case .alarmTime:
            textfieldValue[4] = value
            switchStates[4] = true // Ensure switch is visible after selection
        }
        tableView.reloadData()
    }
}


class ReadOnlyTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false // Disables Cut, Copy, Paste menu
    }
}
