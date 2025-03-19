//
//  Validation.swift
//  HealthCoach
//
//  Created by Keval Thumar on 19/03/25.
//

import Foundation
import UIKit

class Validation {
    static let shared = Validation()
    
    private init() {}
    
    
     func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(
            with: email)
    }
    
     func isValidPassword(_ password: String) -> Bool {
        let passwordRegex =
            #"^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{12,}$"#
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(
            with: password)
    }
    
    
    func checkValidation(for data:[String:String] , viewController:UIViewController) -> Bool {
        
        var errors: [String] = []
        
        data.forEach { (key,textField) in
            if key == "Email" {
                if !isValidEmail(textField) {
                    errors.append("Invalid email format. Please enter a valid email address.")
                }
            }
            
            if key == "Password" {
                if !isValidPassword(textField) {
                    errors.append("Password must be at least 12 characters long, with 1 uppercase, 1 special character, and 1 number.")
                }
            }
            
            if textField.isEmpty {
                errors.append("Please enter \(key)")
            }
            
        }
        
        if !errors.isEmpty {
            Utilities.showAlert(on: viewController, title: "Error", message: errors.first ?? "")
            return false
        }
        
        return true
    }
}
