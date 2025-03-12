//
//  ViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 03/03/25.
//

import UIKit

class OnBoardingCollectionView:  UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var currentPage = 0;
    
    let items = [
          ("Applogo", "Welcome to the HeathCoach World!"),
          ("Onboarding3image", "Your health at a glance"),
          ("Onboarding2image", "the healthCoach Cloud gives you access to your health data anywhere and at any time")
        ]
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnBoardingCollectionViewCell
        let (imageName, title) = items[indexPath.item]
        cell.image.image = UIImage(named: imageName)
        cell.mainLabel.text = title
        if indexPath.item != items.startIndex {
            cell.swipe.isHidden = true
        }
        if indexPath.item != 2 {
            cell.nextLabel.isHidden = true
        }
        
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        print("Width is \(width) and contentOffset is \(scrollView.contentOffset.x)")
        currentPage = Int(scrollView.contentOffset.x / (width - 20))
        print("Current Page is \(currentPage)")
        pageView.currentPage = currentPage
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: view.frame.height-50)
    }
    
    

    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
}

