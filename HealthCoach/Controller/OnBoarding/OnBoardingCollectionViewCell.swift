//
//  OnBoardingCollectionViewCell.swift
//  HealthCoach
//
//  Created by Keval Thumar on 03/03/25.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    

    @IBAction func nextBtnLabel(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "onBoarding")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        let rootViewController = UINavigationController(rootViewController: vc)
        rootViewController.navigationBar.isHidden = true
        self.window?.rootViewController = rootViewController
    }
    @IBOutlet weak var nextLabel: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var swipe: UILabel!
}
