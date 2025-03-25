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

        if Validation.shared.checkValidation(
            for: ["Email": emailTextField.text ?? ""], viewController: self)
        {

            Utilities.showAlert(
                on: self, title: "Success",
                message: "Forget Password Link Sent Successfully",
                isSuccess: true
            )
        }

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
            Navigation.shared.navigate(
                from: self, withIdentifier: "HomeViewController")
        }

    }

    func validateTextField() -> Bool {

        let data = [
            "Email": emailTextField.text ?? "",
            "Password": passwordTextField.text ?? "",
        ]
        if !Validation.shared.checkValidation(for: data, viewController: self) {
            return false
        }
        
        return true
    }
    var textFieldHandler: TextFieldNavigationHandler?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGestureToDismissKeyboard()
        textFieldHandler = TextFieldNavigationHandler(textFields: [emailTextField, passwordTextField])
    }

    func setupTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(
            target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
