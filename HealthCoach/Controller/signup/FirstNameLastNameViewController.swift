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
        validateTextField()
        sendData()
    }
    
    func sendData() {
        print(
            """
            FirstName:- \(firstNameTextField.text ?? "FName")
            LastName:- \(lastNameTextField.text ?? "LName")
            """
        )
        let birthHeightGenderVC = self.storyboard?.instantiateViewController(identifier: "BirthHeightGenderViewController") as! BirthHeightGenderViewController
        self.navigationController?.pushViewController(birthHeightGenderVC, animated: true)
    }
    
    func validateTextField() {
        guard !firstNameTextField.text!.isEmpty, !lastNameTextField.text!.isEmpty else {
            Utilities.showAlert(
                on:  self, title: "Error",
                message: "Please fill all the fields")
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
