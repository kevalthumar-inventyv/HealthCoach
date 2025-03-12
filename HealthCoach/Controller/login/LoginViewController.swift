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

        guard Utilities.isValidEmail(email) else {
            Utilities.showAlert(
                on: self, title: "Error",
                message:
                    "Invalid email format. Please enter a valid email address.")
            return
        }
        
        Utilities.showAlert(
            on: self, title: "Success", message: "Forget Password Link Sent Successfully",
            isSuccess: true
        )
        
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func nextBtn(_ sender: UIButton) {
        validateTextField()
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
            let HomeVC =
                self.storyboard?.instantiateViewController(
                    identifier: "HomeViewController")
                as! HomeViewController
            self.navigationController?.pushViewController(
                HomeVC, animated: true)
        }

    }

    func validateTextField() {
        guard let email = emailTextField.text, !email.isEmpty else {
            Utilities.showAlert(
                on: self, title: "Error", message: "Please enter an email.")
            return
        }

        guard Utilities.isValidEmail(email) else {
            Utilities.showAlert(
                on: self, title: "Error",
                message:
                    "Invalid email format. Please enter a valid email address.")
            return
        }

        guard let password = passwordTextField.text, !password.isEmpty else {
            Utilities.showAlert(
                on: self, title: "Error", message: "Please enter a password.")
            return
        }

        guard Utilities.isValidPassword(password) else {
            Utilities.showAlert(
                on: self, title: "Error",
                message:
                    "Password must be at least 12 characters long, with 1 uppercase, 1 special character, and 1 number."
            )
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
