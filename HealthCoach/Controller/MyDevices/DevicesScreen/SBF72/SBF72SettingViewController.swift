//
//  SBF72SettingViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 05/03/25.
//

import UIKit

class SBF72SettingViewController: UIViewController {

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let HomeVC = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(HomeVC, animated: true)
        }
    }
   
}
