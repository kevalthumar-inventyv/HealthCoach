
//
//  DisclaimerViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 17/03/25.
//

import UIKit

class DisclaimerViewController : UIViewController {
    
    @IBAction func btnBack(_ sender: UIButton) {
           Navigation.shared.popViewController(from: self)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
