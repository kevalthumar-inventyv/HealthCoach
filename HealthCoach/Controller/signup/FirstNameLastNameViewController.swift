//
//  FirstNameLastNameViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 03/03/25.
//

import UIKit

class FirstNameLastNameViewController: UIViewController {

    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
        print(#function)
        let data = [
            "FirstName": firstNameTextField.text ?? "FName",
            "LastName": lastNameTextField.text ?? "LName"
        ]
        if !Validation.shared.checkValidation(for: data, viewController: self){
            return
        }
        sendData()
    }
    
    func sendData() {
        print(
            """
            FirstName:- \(firstNameTextField.text ?? "FName")
            LastName:- \(lastNameTextField.text ?? "LName")
            """
        )
        Navigation.shared.navigate(from: self, withIdentifier: "BirthHeightGenderViewController")
    }
    
    var textFieldHandler: TextFieldNavigationHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGestureToDismissKeyboard()
        textFieldHandler = TextFieldNavigationHandler(textFields: [firstNameTextField, lastNameTextField])
    }
    
    func setupTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
