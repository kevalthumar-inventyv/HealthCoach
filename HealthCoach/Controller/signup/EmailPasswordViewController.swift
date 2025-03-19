//
//  EmailPasswordViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 03/03/25.
//
import UIKit

class EmailPasswordViewController: UIViewController {

    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var checkboxButton: UIButton!

    var isChecked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCheckbox()
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func checkboxTapped(_ sender: UIButton) {
        isChecked.toggle()
        updateCheckbox()
    }

    func updateCheckbox() {
        let imageName = isChecked ? "checkmark.square.fill" : "square"
        checkboxButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @IBAction func nextBtn(_ sender: UIButton) {
        if !validateFields() {
            return
        }
        Utilities.showAlert(
            on: self, title: "Success", message: "You can proceed!",
            isSuccess: true
        ) {
            self.sendData()
            Navigation.shared.navigate(from: self, withIdentifier: "FirstNameLastNameViewController")
        }
    }

    // MARK: - Validation Function
    func validateFields() -> Bool{
        let validation = Validation.shared

        let data = [
            "Email" : emailTextField.text ?? "",
            "Password" : PasswordTextField.text ?? "",
            "Confirm Password" : confirmPasswordTextField.text ?? ""
        ]
        if !validation.checkValidation(for: data, viewController: self) {
            return false
        }

        guard
            PasswordTextField.text ?? "" == confirmPasswordTextField.text ?? ""
        else {
            Utilities.showAlert(
                on: self, title: "Error",
                message: "Passwords do not match. Please try again.")
            return false
        }
        return true
        
    }

    // MARK: - Send data to API
    func sendData() {
        print(
            """
            Email:- \(emailTextField.text ?? "Email")
            Password:- \(PasswordTextField.text ?? "Password")
            Confirm Password:- \(confirmPasswordTextField.text ?? "CPassword")
            CheckBox:- \(isChecked)
            """
        )
    }

    // MARK: - Password Visibility Toggle
    @IBAction func cEye(_ sender: UIButton) {
        Utilities.toggleEye(for: confirmPasswordTextField, sender: sender)
    }

    @IBAction func pEye(_ sender: UIButton) {
        Utilities.toggleEye(for: PasswordTextField, sender: sender)
    }
}
