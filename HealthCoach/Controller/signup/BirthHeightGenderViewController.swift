//
//  BirthHeightGenderViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 04/03/25.
//

import UIKit

class BirthHeightGenderViewController: UIViewController, UITextFieldDelegate {
    var howItCome = "WithSignupMethod"
    
    @IBAction func nextBtn(_ sender: UIButton) {
        validateTextField()
        sendData()
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var BirthdayTextField: UITextField!
    @IBOutlet weak var HeightTextField: UITextField!
    @IBOutlet weak var maleRadioButton: UIButton!
    @IBOutlet weak var femaleRadioButton: UIButton!
    var selectedGender: String = "Male"

    override func viewDidLoad() {
        super.viewDidLoad()
        BirthdayTextField.delegate = self
        HeightTextField.delegate = self
        updateRadioButtons()
    }

    func sendData() {
        print(
            """
            BirthDay:- \(BirthdayTextField.text ?? "FName")
            Height:- \(HeightTextField.text ?? "LName")
            Gender:- \(selectedGender)
            """
        )
        showCustomActionSheet(on: self)
    }

    func showCustomActionSheet(on viewController: UIViewController) {
        let alert = UIAlertController(
            title: "HealthCoach",
            message:
                "By clicking on Sign up, you agree to the Sanitas Terms and Conditions and data privacy policies.",
            preferredStyle: .actionSheet)

        // Customize title appearance
        let titleFont = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
        ]
        let attributedTitle = NSAttributedString(
            string: "HealthCoach", attributes: titleFont)
        alert.setValue(attributedTitle, forKey: "attributedTitle")

        // Terms and Conditions
        let termsAction = UIAlertAction(
            title: "Terms and Conditions", style: .default
        ) { _ in
            self.openURL(
                "https://connect.sanitas-online.de/ConLegalInformation.aspx?q=TermsOfUse&p=AN&cu=en-US"
            )
        }

        // Data Privacy Policy
        let privacyAction = UIAlertAction(
            title: "Data privacy policies", style: .default
        ) { _ in
            self.openURL(
                "https://connect.sanitas-online.de/ConLegalInformation.aspx?q=PrivacyPolicy&p=AN&cu=en-US"
            )
        }

        // Cancel Button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        // Sign Up
        let signUpAction = UIAlertAction(title: "Sign up", style: .default) {
            _ in
            Utilities.showAlert(
                on: self, title: "HealthCoach App",
                message: """
                            Thank you for registering!
                            You will shortly receive an email to activate your account.
                            You can now use the app for 24 hours. If you do not confirm your account, you will be logged out and your data will be deleted.
                    """, isSuccess: true) {
                        if self.howItCome == "WithSignupMethod" {
                            let finalSignupVC = self.storyboard?.instantiateViewController(identifier: "FinalSignupScreenViewController") as! FinalSignupScreenViewController
                                                    self.navigationController?.pushViewController(finalSignupVC, animated: true)
                        }
                        else if self.howItCome == "WithoutSignupMethod" {
                            let myDevicesVC = self.storyboard?.instantiateViewController(identifier: "MyDevicesViewController") as! MyDevicesViewController
                            self.navigationController?.pushViewController(myDevicesVC, animated: true)
                        }
                    }
        }

        // Add actions
        alert.addAction(termsAction)
        alert.addAction(privacyAction)
        alert.addAction(cancelAction)
        alert.addAction(signUpAction)

        // Present the alert
        viewController.present(alert, animated: true)
    }

    // Function to open URL in Safari
    private func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func validateTextField() {
        guard !BirthdayTextField.text!.isEmpty, !HeightTextField.text!.isEmpty
        else {
            Utilities.showAlert(
                on: self, title: "Error",
                message: "Please fill all the fields")
            return
        }
    }

    @objc func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == BirthdayTextField {
            birthdayPickerBtn(textField)  // Call your date picker function
        } else if textField == HeightTextField {
            heightPickerBtn(textField)  // Call your height picker function
        }
        return false  // **Disables keyboard opening**
    }

    @IBAction func birthdayPickerBtn(_ sender: UITextField) {
        Utilities.showDatePicker(on: self) { selectedDate in
            self.BirthdayTextField.text = selectedDate
        }
    }

    @IBAction func heightPickerBtn(_ sender: UITextField) {
        print("Clicked")
        Utilities.showHeightPicker(on: self) { selectedHeight in
            self.HeightTextField.text = selectedHeight
        }
    }

    @IBAction func maleRadioBtn(_ sender: UIButton) {
        selectedGender = "Male"
        updateRadioButtons()
    }

    @IBAction func femaleRadioBtn(_ sender: UIButton) {
        selectedGender = "Female"
        updateRadioButtons()
    }

    func updateRadioButtons() {
        let config = UIImage.SymbolConfiguration(scale: .medium)
        let selectedImage = UIImage(
            systemName: "largecircle.fill.circle", withConfiguration: config)
        let unselectedImage = UIImage(
            systemName: "circle", withConfiguration: config)

        maleRadioButton.setImage(
            selectedGender == "Male" ? selectedImage : unselectedImage,
            for: .normal)
        femaleRadioButton.setImage(
            selectedGender == "Female" ? selectedImage : unselectedImage,
            for: .normal)
    }
}
