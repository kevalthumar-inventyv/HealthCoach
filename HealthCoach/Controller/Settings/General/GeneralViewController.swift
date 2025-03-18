
//
//  GeneralViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 18/03/25.
//

import UIKit

class GeneralViewController : UIViewController, UITextFieldDelegate{
    
    var selectedGender: String = "Male"
    
    @IBOutlet weak var btnFemaleOut: UIButton!
    @IBOutlet weak var btnMaleOut: UIButton!
    @IBOutlet weak var textfieldFirstName: UnderlinedTextField!
    
@IBOutlet weak var textfieldLastName: UnderlinedTextField!
    
@IBOutlet weak var textfieldBirthDayOut: UnderlinedTextField!
    
@IBOutlet weak var textfieldHeightOut: UnderlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldBirthDayOut.delegate = self
        textfieldHeightOut.delegate = self
        updateRadioButtons()
    }
    
    
    func updateRadioButtons() {
        let config = UIImage.SymbolConfiguration(scale: .medium)
        let selectedImage = UIImage(
            systemName: "largecircle.fill.circle", withConfiguration: config)
        let unselectedImage = UIImage(
            systemName: "circle", withConfiguration: config)

        btnMaleOut.setImage(
            selectedGender == "Male" ? selectedImage : unselectedImage,
            for: .normal)
        btnFemaleOut.setImage(
            selectedGender == "Female" ? selectedImage : unselectedImage,
            for: .normal)
    }
    
    
    
    @IBAction func btnFemale(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func btnMale(_ sender: UIButton) {
        
        
    }
    
    @IBAction func textfieldBirthDay(_ sender: UnderlinedTextField) {
        Utilities.showDatePicker(on: self) { selectedDate in
            self.textfieldBirthDayOut.text = selectedDate
        }
    }
    
    
    @IBAction func textfieldHeight(_ sender: UnderlinedTextField) {
        Utilities.showHeightPicker(on: self) { selectedHeight in
            self.textfieldHeightOut.text = selectedHeight
        }
    }

    
    @objc func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == textfieldBirthDayOut {
            textfieldBirthDay(textField as! UnderlinedTextField)  // Call your date picker function
        } else if textField == textfieldHeightOut {
            textfieldHeight(textField as! UnderlinedTextField)  // Call your height picker function
        }
        return false
    }
    
}
