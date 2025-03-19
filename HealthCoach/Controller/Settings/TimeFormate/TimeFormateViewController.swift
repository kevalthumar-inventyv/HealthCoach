//
//  TimeFormateViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 18/03/25.
//

import UIKit

class TimeFormateViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        Navigation.shared.popViewController(from: self)
    }
}

