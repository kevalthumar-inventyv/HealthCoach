
//
//  SendFeedbackViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 17/03/25.
//

import UIKit

class SendFeedbackViewController : UIViewController {
    
    @IBAction func btnBack(_ sender: UIButton) {
           Navigation.shared.popViewController(from: self)
       }
    
    var isChecked : Bool = false
    
    @IBAction func btnCheckBox(_ sender: UIButton) {
        isChecked.toggle()
        if isChecked {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
