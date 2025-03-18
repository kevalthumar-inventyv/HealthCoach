//
//  AboutViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 17/03/25.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var LinkLabel: UILabel!
    @IBOutlet weak var LinkLabel2: UILabel!
    
    @IBAction func btnBack(_ sender: UIButton) {
           Navigation.shared.popViewController(from: self)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Apply hyperlink style without changing the color set in Storyboard
        applyLinkStyle(
            to: LinkLabel, text: "www.sanitas-online.de",
            urlString: "https://www.sanitas-online.de")
        applyLinkStyle(
            to: LinkLabel2, text: "www.dynamic1001.com",
            urlString: "https://www.dynamic1001.com")
    }
    func applyLinkStyle(to label: UILabel, text: String, urlString: String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            .underlineStyle, value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: text.count))
        label.attributedText = attributedString
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(
            target: self, action: #selector(openLink(_:)))
        label.addGestureRecognizer(tapGesture)
        label.tag = urlString.hash  // Store URL in tag
    }
    @objc func openLink(_ sender: UITapGestureRecognizer) {
        if let label = sender.view as? UILabel {
            let urlString =
                (label.tag == "https://www.sanitas-online.de".hash)
                ? "https://www.sanitas-online.de"
                : "https://www.dynamic1001.com"
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
}
