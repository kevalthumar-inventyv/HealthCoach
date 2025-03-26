//
//  MedicationViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 17/03/25.
//

import UIKit

class MedicationViewController: UIViewController {

    @IBAction func btnAddMedication(_ sender: UIButton) {
        let formVC = Navigation.shared.navigate(
            from: self, withIdentifier: "MedicationFormViewController") as! MedicationFormViewController
        formVC.isEditing = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        SideMenuManager.shared.showSideMenu(in: self, sideMenuView: sideView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Print the actual width to debug
        print("Side menu width before adjustment: \(sideView.frame.width)")

        // Ensure the menu is hidden off-screen
        sideView.frame.origin.x = -sideView.frame.width
    }

    @IBOutlet weak var sideView: UIView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sideView.frame.origin.x = -sideView.frame.width
    }

    @IBAction func btnSideMenu(_ sender: UIButton) {
        sideView.alpha = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SideMenuManager.shared.openSideMenu()
        }
    }

    @IBAction func btnMedicationSide(_ sender: UIButton) {
        print("Medication button tapped")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SideMenuManager.shared.closeSideMenu()
        }
    }

    @IBAction func btnHomeSide(_ sender: UIButton) {
        print("Home button tapped")
        Navigation.shared.navigate(
            from: self, withIdentifier: "HomeViewController")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SideMenuManager.shared.closeSideMenu()
        }
    }

    @IBAction func btnMoreSide(_ sender: UIButton) {
        print("More button tapped")
        Navigation.shared.navigate(
            from: self, withIdentifier: "MoreViewController")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SideMenuManager.shared.closeSideMenu()
        }
    }

    @IBAction func btnSettingsSide(_ sender: UIButton) {
        print("Settings button tapped")
        Navigation.shared.navigate(
            from: self, withIdentifier: "SettingsViewController")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SideMenuManager.shared.closeSideMenu()
        }
    }

}
