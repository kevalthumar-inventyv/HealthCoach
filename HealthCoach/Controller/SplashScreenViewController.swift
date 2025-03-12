//
//  LaunchScreenViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 03/03/25.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        animateImageUp()
    }

    func animateImageUp() {
        imageView.alpha = 0.5
        let screenHeight = view.frame.height
                self.bottomConstraint.constant = screenHeight / 2 - (imageView.frame.height / 2)

        UIView.animate(
            withDuration: 2, delay: 0.2, options: [.curveEaseInOut],
            animations: {
                self.imageView.alpha = 1
                self.view.layoutIfNeeded()
            }) { success in
                if success
                    {
                    let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "onBoarding")
                    if hasSeenOnboarding {
                        let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                        self.navigationController?.pushViewController(welcomeVC, animated: true)
                        return
                    }
                    else{
                        let onBoardingVC = self.storyboard?.instantiateViewController(identifier: "OnBoardingCollectionView") as! OnBoardingCollectionView
                        self.navigationController?.pushViewController(onBoardingVC, animated: true)
                        return
                    }
                    
                }
            }
    }
}
