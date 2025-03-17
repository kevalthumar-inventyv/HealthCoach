//
//  MoreViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 13/03/25.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var sideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorInset = .zero
        SideMenuManager.shared.showSideMenu(in: self, sideMenuView: sideView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sideView.frame.origin.x = -sideView.frame.width
    }

    @IBAction func btnSideMenu(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SideMenuManager.shared.openSideMenu()
        }
    }

    @IBAction func btnMedicationSide(_ sender: UIButton) {
 Navigation.shared.navigate(from: self, withIdentifier: "MedicationViewController")
        
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                   SideMenuManager.shared.closeSideMenu()
               }
    }

    @IBAction func btnHomeSide(_ sender: UIButton) {
        print("Home button tapped")
                Navigation.shared.navigate(from: self, withIdentifier: "HomeViewController")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    SideMenuManager.shared.closeSideMenu()
                }
    }

    @IBAction func btnMoreSide(_ sender: UIButton) {

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    SideMenuManager.shared.closeSideMenu()
                }
    }

    @IBAction func btnSettingsSide(_ sender: UIButton) {
        print("Settings button tapped")
                Navigation.shared.navigate(from: self, withIdentifier: "SettingsViewController")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    SideMenuManager.shared.closeSideMenu()
                }
    }

    @IBOutlet weak var tableView: UITableView!

    let mySectionFields = [
        ["Synchronisation", "About", "Export", "Rate the App"],
        ["Send feedback", "FAQ", "App Tour"],
        ["Imprint", "Terms and Conditions", "Data protection", "Disclaimer"],
    ]

}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return mySectionFields.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return mySectionFields[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MoreCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = mySectionFields[indexPath.section][indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }

    func tableView(
        _ tableView: UITableView, heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 5
    }

//    func tableView(
//        _ tableView: UITableView, viewForHeaderInSection section: Int
//    ) -> UIView? {
//        let headerView = UIView(
//            frame: CGRect(
//                x: 0, y: 0, width: tableView.frame.width - 10, height: 5))
//        let label = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.width - 20, height: 5))
//        label.text = " "
//        headerView.addSubview(label)
//        return headerView
//    }
    
    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        print("Selected: \(mySectionFields[indexPath.section][indexPath.row])")
    }
}
