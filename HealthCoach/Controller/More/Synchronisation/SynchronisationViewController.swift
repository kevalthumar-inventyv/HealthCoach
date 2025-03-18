//
//  SynchronisationViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 17/03/25.
//

import UIKit

class SynchronisationViewController: UIViewController {
    
    func showLoadingThenAlert() {
        let loadingAlert = UIAlertController(title: nil, message: "Synchronization...", preferredStyle: .alert)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10 // Added spacing between elements
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        
        // Add a spacer view to create space from the alert view edges
        let spacer = UIView()
        spacer.widthAnchor.constraint(equalToConstant: 5).isActive = true  // Space from left edge
        
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(indicator)
        
        loadingAlert.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: loadingAlert.view.leadingAnchor, constant: 10), // Add left padding
            stackView.centerYAnchor.constraint(equalTo: loadingAlert.view.centerYAnchor),
        ])
        
        present(loadingAlert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            loadingAlert.dismiss(animated: true) {
                self.showConfirmationAlert()
            }
        }
    }

    
    
    func showConfirmationAlert() {
        let alert = UIAlertController(title: "Action Required", message: "Do you want to proceed?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("OK button tapped")
        }))
        
        present(alert, animated: true)
    }
    
    @IBAction func btnSync(_ sender: UIButton) {
        self.showLoadingThenAlert()
    }
    @IBAction func btnBack(_ sender: UIButton) {
        Navigation.shared.popViewController(from: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
