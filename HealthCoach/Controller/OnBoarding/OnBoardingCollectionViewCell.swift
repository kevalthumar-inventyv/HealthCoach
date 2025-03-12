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
        print("Next Button Clicked")
    }
    @IBOutlet weak var nextLabel: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var swipe: UILabel!
}
