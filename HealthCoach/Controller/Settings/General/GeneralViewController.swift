
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
    
    var navigationHandler: TextFieldNavigationHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldBirthDayOut.delegate = self
        textfieldHeightOut.delegate = self
        updateRadioButtons()
        setupTapGestureToDismissKeyboard()
        navigationHandler = TextFieldNavigationHandler(textFields: [textfieldFirstName, textfieldLastName])
    }

    func setupTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        Navigation.shared.popViewController(from: self)
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        

        let userData: [String: String] = [
            "gender": selectedGender,
            "FirstName": textfieldFirstName.text ?? "",
            "LastName": textfieldLastName.text ?? "",
            "Height": textfieldHeightOut.text ?? "",
            "DateOfBirth": textfieldBirthDayOut.text ?? ""
        ]
        
        if !Validation.shared.checkValidation(for: userData, viewController: self ) { return }
        
        UserDefaults.standard.setValuesForKeys(userData)

        Utilities.showAlert(on: self, title: "Success", message: "Data saved successfully",isSuccess: true) {
            Navigation.shared.navigate(from: self, withIdentifier: "HomeViewController")
        }
    }

 

    
    @IBAction func btnFemale(_ sender: UIButton) {
        
        selectedGender = "Female"
        updateRadioButtons()
    }
    
    
    @IBAction func btnMale(_ sender: UIButton) {
        
        selectedGender = "Male"
        updateRadioButtons()
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
