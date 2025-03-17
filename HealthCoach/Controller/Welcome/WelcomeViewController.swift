//
//  WelcomeViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 03/03/25.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBAction func signupBtn(_ sender: UIButton) {

        let privacyVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        privacyVC.howItCome = "WithSignupMethod"
        navigationController?.pushViewController(privacyVC, animated: true)
    }
    
    @IBAction func continueBtn(_ sender: UIButton) {
        
        
        let privacyVC = Navigation.shared.navigate(from: self, withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        
        
//        let privacyVC = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        privacyVC.howItCome = "WithoutSignupMethod"
//        navigationController?.pushViewController(privacyVC, animated: true)
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
