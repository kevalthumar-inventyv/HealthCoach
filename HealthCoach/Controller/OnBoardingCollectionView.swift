//
//  ViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 03/03/25.
//

import UIKit

class OnBoardingCollectionView: UICollectionView , UICollectionViewDelegate, UICollectionViewDataSource {
    
    let items = [
          ("Applogo 2", "Welcome to the HeathCoach World!"),
          ("Onboarding2image", "Your health at a glance"),
          ("Onboarding3image", "the healthCoach Cloud gives you access to your health data anywhere and at any time")
        ]
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnBoardingCollectionViewCell
        print("item:- \(indexPath.item)")
        print("row:- \(indexPath.row)")
        let (imageName, title) = items[indexPath.item]
        cell.image.image = UIImage(named: imageName)
        cell.mainLabel.text = title
        if indexPath.item != items.startIndex {
            cell.swipe.isHidden = true
        }
        if indexPath.item != items.endIndex {
            cell.nextLabel.isHidden = true
        }
        
        return cell
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    
}

