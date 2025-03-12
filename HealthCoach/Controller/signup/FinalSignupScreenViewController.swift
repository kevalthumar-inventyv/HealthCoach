//
//  FinalSignupScreenViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 04/03/25.
//

import UIKit

class FinalSignupScreenViewController: UIViewController {

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtn(_ sender: UIButton) {
        let appIntroVC = self.storyboard?.instantiateViewController(identifier: "AppIntroViewController") as! AppIntroViewController
            self.navigationController?.pushViewController(appIntroVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
