//
//  MedicationFormViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 26/03/25.
//

import UIKit

class MedicationFormViewController: UIViewController {

    @IBOutlet weak var textMedication: UITextField!

    @IBOutlet weak var textStrength: UITextField!
    @IBOutlet weak var textDose: UITextField!
    @IBOutlet weak var textFrequency: UITextField!
    @IBOutlet weak var textReasonForIntake: UITextField!
    @IBOutlet weak var textComment: UITextField!
    var isEditingForm: Bool = false
    @IBAction func btnDeleteClick(_ sender: UIButton) {
    }

    @IBAction func btnSaveClick(_ sender: UIButton) {
        let data = [
            "Medication": textMedication.text ?? "",
            "Strength": textStrength.text ?? "",
            "Dose": textDose.text ?? "",
            "Frequency": textFrequency.text ?? "",
            "ReasonForIntake": textReasonForIntake.text ?? "",
            "Comment": textComment.text ?? "",
        ]
        if !Validation.shared.checkValidation(for: data, viewController: self) {
            return
        }
    }
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnDelete: UIButton!

    var textFieldHandler: TextFieldNavigationHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldHandler = TextFieldNavigationHandler(textFields: [
            textMedication,
            textStrength, textDose, textFrequency, textReasonForIntake,
            textComment,
        ])
        setupTapGestureToDismissKeyboard()
        btnSave.setTitle(isEditingForm ? "Update" : "Save", for: .normal)
        btnDelete.isHidden = !isEditingForm
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
