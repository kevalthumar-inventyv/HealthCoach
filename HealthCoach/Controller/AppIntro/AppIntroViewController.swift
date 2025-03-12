//
//  AppIntroViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 04/03/25.
//
import UIKit

class AppIntroViewController: UIViewController, UICollectionViewDataSource {

    let image = [
        UIImage(named: "appIntro_1"),
        UIImage(named: "appIntro_2"),
        UIImage(named: "appIntro_3"),
        UIImage(named: "appIntro_4"),
        UIImage(named: "appIntro_5"),
        UIImage(named: "appIntro_6"),
    ]
    
    var currentPage = 0

    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var swipeOut: UIButton!
    @IBOutlet weak var continueBtnOut: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        pageView.numberOfPages = image.count
        updateButtons()
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appintrocell", for: indexPath) as! AppIntroCollectionViewCell
        cell.image.image = image[indexPath.row]
        
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / (width))
        pageView.currentPage = currentPage
        updateButtons()
    }

    func updateButtons() {
        continueBtnOut.isHidden = currentPage != image.count - 1
        swipeOut.isHidden = currentPage != 0
    }

    @IBAction func continueBtn(_ sender: UIButton) {
        let myDevicesVC = self.storyboard?.instantiateViewController(identifier: "MyDevicesViewController") as! MyDevicesViewController
        self.navigationController?.pushViewController(myDevicesVC, animated: true)
    }
}

extension AppIntroViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(self.collectionView.frame.width)
        print(collectionView.frame.width)
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height   )
    }
}
