
//
//  ExportViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 17/03/25.
//

import UIKit

class ExportViewController : UIViewController {
    
    @IBAction func btnBack(_ sender: UIButton) {
           Navigation.shared.popViewController(from: self)
       }
    
    @IBAction func btnExport(_ sender: UIButton) {
        if let image = UIImage(named: "Applogo") {
                let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                present(activityVC, animated: true)
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


