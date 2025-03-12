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
        let imageName = isChecked ? "checkmark.square" : "square"
        checkboxButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @IBAction func nextBtn(_ sender: UIButton) {
        validateFields()
    }

    // MARK: - Validation Function
    func validateFields() {
        guard let email = emailTextField.text, !email.isEmpty else {
            Utilities.showAlert(on: self, title: "Error", message: "Please enter an email.")
            return
        }

        guard Utilities.isValidEmail(email) else {
            Utilities.showAlert(on: self, title: "Error", message: "Invalid email format. Please enter a valid email address.")
            return
        }

        guard let password = PasswordTextField.text, !password.isEmpty else {
            Utilities.showAlert(on: self, title: "Error", message: "Please enter a password.")
            return
        }

        guard Utilities.isValidPassword(password) else {
            Utilities.showAlert(on: self, title: "Error", message: "Password must be at least 12 characters long, with 1 uppercase, 1 special character, and 1 number.")
            return
        }

        guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            Utilities.showAlert(on: self, title: "Error", message: "Please confirm your password.")
            return
        }

        guard password == confirmPassword else {
            Utilities.showAlert(on: self, title: "Error", message: "Passwords do not match. Please try again.")
            return
        }

        Utilities.showAlert(on: self, title: "Success", message: "You can proceed!", isSuccess: true) {
            self.sendData()
            let firstNameLastNameVC = self.storyboard?.instantiateViewController(identifier: "FirstNameLastNameViewController") as! FirstNameLastNameViewController
            self.navigationController?.pushViewController(firstNameLastNameVC, animated: true)
        }
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
