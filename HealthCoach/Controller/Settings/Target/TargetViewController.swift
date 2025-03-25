//
//  TargetViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 18/03/25.
//

import UIKit

class TargetViewController: UIViewController ,UITextFieldDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldSleepOut.delegate = self
        textfieldActivityOut.delegate = self
        setupTapGestureToDismissKeyboard()
    }
    
    func setupTapGestureToDismissKeyboard() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
        }

        @objc func dismissKeyboard() {
            view.endEditing(true)
        }

    @IBOutlet weak var textfieldActivityOut: UnderlinedTextField!

    @IBAction func textfieldActivity(_ sender: UnderlinedTextField) {
        Utilities.showActivityPicker(on: self) { selectedValue in
            self.textfieldActivityOut.text = selectedValue
        }
    }

    @IBOutlet weak var textfieldSleepOut: UnderlinedTextField!

    @IBAction func textfieldSleep(_ sender: UnderlinedTextField) {
        Utilities.showTargetSleepPicker(on: self) { selectedValue in
            self.textfieldSleepOut.text = selectedValue
        }
    }

    @IBAction func btnBack(_ sender: UIButton) {
        Navigation.shared.popViewController(from: self)
    }

    @objc func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == textfieldSleepOut {
            textfieldSleep(textField as! UnderlinedTextField)  // Call your date picker function
        } else if textField == textfieldActivityOut {
            textfieldActivity(textField as! UnderlinedTextField)  // Call your height picker function
        }
        return false
    }
}
