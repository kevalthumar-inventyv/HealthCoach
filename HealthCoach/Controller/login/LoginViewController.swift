//
//  LoginViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 06/03/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func pEye(_ sender: UIButton) {
        Utilities.toggleEye(for: passwordTextField, sender: sender)
    }

    @IBAction func forgetPasswordBtn(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            Utilities.showAlert(
                on: self, title: "Error", message: "Please enter an email.")
            return
        }

        guard Validation.shared.isValidEmail(email) else {
            Utilities.showAlert(
                on: self, title: "Error",
                message:
                    "Invalid email format. Please enter a valid email address.")
            return
        }

        Utilities.showAlert(
            on: self, title: "Success",
            message: "Forget Password Link Sent Successfully",
            isSuccess: true
        )

    }

    @IBAction func backBtn(_ sender: UIButton) {
        Navigation.shared.popToRootViewController(from: self)
    }

    @IBAction func nextBtn(_ sender: UIButton) {
        if !validateTextField() {
            return
        }
        sendData()
    }

    func sendData() {
        print(
            """
                        password:- \(passwordTextField.text ?? "FName")
                        emailText:- \(emailTextField.text ?? "LName")
            """
        )
        Utilities.showAlert(
            on: self, title: "Success", message: "Login Successfully",
            isSuccess: true
        ) {
            Navigation.shared.navigate(from: self, withIdentifier: "HomeViewController")
        }

    }

    func validateTextField() -> Bool{

        let data = [
            "Email" : emailTextField.text ?? "",
            "Password" : passwordTextField.text ?? ""
        ]
        if Validation.shared.checkValidation(for: data, viewController: self) {
            return false
        }

        guard Validation.shared.isValidEmail(emailTextField.text ?? "") else {
            Utilities.showAlert(
                on: self, title: "Error",
                message:
                    "Invalid email format. Please enter a valid email address.")
            return false
        }
        guard Validation.shared.isValidPassword(passwordTextField.text ?? "")
        else {
            Utilities.showAlert(
                on: self, title: "Error",
                message:
                    "Password must be at least 12 characters long, with 1 uppercase, 1 special character, and 1 number."
            )
            return false
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
