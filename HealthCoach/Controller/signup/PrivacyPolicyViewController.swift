//
//  PrivacyPolicyViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 03/03/25.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    var howItCome : String = "WithSignupMethod"
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func agreeBtn(_ sender: UIButton) {
        
        let NextVC = Navigation.shared.makeConditionViewController(
            firstIdentifier: "EmailPasswordViewController" ,
            secondIdentifier: "BirthHeightGenderViewController",
            from: self,
            condition: howItCome == "WithSignupMethod"
        )
        
        if let BirthdayHeightGenderVC = NextVC as? BirthHeightGenderViewController {
            BirthdayHeightGenderVC.howItCome = howItCome
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
          textView.attributedText = getFormattedConsentText()
          textView.isEditable = false // Make sure the user cannot edit the text
          textView.isSelectable = true // Allow user interaction for links
          textView.dataDetectorTypes = [.link] // Enable link detection
      }
    
    func getFormattedConsentText() -> NSAttributedString {
        let text = """
        Consent Regarding Health-Related Data

        Before launching the app, we would like to provide you with the following information:

        This app processes "data related to health" pursuant to the General Data Protection Regulation (GDPR). In order to properly guarantee the processing of this type of data, we require a declaration of consent from you.

        I hereby consent to the processing of my personal data, including:
        • Blood pressure
        • Weight
        • Number of steps
        • Duration of sleep
        • Height
        • Date of birth
        • Gender

        These data will be processed for the purpose of using the app.

        Right to Object:
        I am aware that I may revoke my consent at any time with immediate effect.

        Obligations to Inform: Link to Data Protection Statement
        """

        let attributedString = NSMutableAttributedString(string: text)

        let defaultFont = UIFont.systemFont(ofSize: 15)
        attributedString.addAttribute(.font, value: defaultFont, range: NSRange(location: 0, length: attributedString.length))

        let boldFont = UIFont.boldSystemFont(ofSize: 15)
        let boldAttributes: [NSAttributedString.Key: Any] = [.font: boldFont]

        if let range = text.range(of: "Consent Regarding Health-Related Data") {
            attributedString.addAttributes(boldAttributes, range: NSRange(range, in: text))
        }
        
        if let range = text.range(of: "Link to Data Protection Statement") {
            let linkAttributes: [NSAttributedString.Key: Any] = [
                .link: URL(string: "https://connect.sanitas-online.de/ConLegalInformation.aspx?p=AN&q=PrivacyPolicy&cu=en-US")!,
                .foregroundColor: UIColor.blue,
                .underlineStyle: NSUnderlineStyle.single.rawValue // Underline the text
            ]
            attributedString.addAttributes(linkAttributes, range: NSRange(range, in: text))
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }

  }
