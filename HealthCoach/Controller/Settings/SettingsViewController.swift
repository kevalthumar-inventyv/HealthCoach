//
//  SettingsViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 13/03/25.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var sideView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorInset = .zero
        tableView.register(
            UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
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
        print("Medication button tapped")
        Navigation.shared.navigate(
            from: self, withIdentifier: "MedicationViewController")

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

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SideMenuManager.shared.closeSideMenu()
        }
    }

    @IBOutlet weak var tableView: UITableView!

    let mySectionFields = [
        ["General", "Code lock"],
        ["Add device"],
        [
            "Target", "Language", "Unit", "Date format", "Time format",
            "First day of week",
        ],
        ["Logout"],
        ["Register online"],
    ]

    let sectionHeaders: [String] = [
        "Profile", "My devices", "System settings", "Logout", "Register online",
    ]

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return mySectionFields.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return mySectionFields[section].count
    }

    func tableView(
        _ tableView: UITableView, heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "SettingsCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = mySectionFields[indexPath.section][indexPath.row]
        cell.contentConfiguration = content
        return cell
    }

    //    func tableView(
    //        _ tableView: UITableView, titleForHeaderInSection section: Int
    //    ) -> String? {
    //        return sectionHeaders[section]
    //    }
    //
    //    func tableView(
    //        _ tableView: UITableView, heightForHeaderInSection section: Int
    //    ) -> CGFloat {
    //        return 10
    //    }

    func tableView(
        _ tableView: UITableView, viewForHeaderInSection section: Int
    ) -> UIView? {
        let headerView = UIView(
            frame: CGRect(
                x: 0, y: 0, width: tableView.frame.width, height: 10))
        headerView.backgroundColor = UIColor(
            red: 202 / 255, green: 202 / 255, blue: 202 / 255, alpha: 1.00)
        let label = UILabel(
            frame: CGRect(x: 5, y: 0, width: tableView.frame.width, height: 18))
        label.text = sectionHeaders[section]
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        headerView.addSubview(label)
        return headerView
    }

    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        let selectedItem = mySectionFields[indexPath.section][indexPath.row]
        print("Selected: \(selectedItem)")

        let viewControllerMap: [String: String] = [
            "General": "GeneralViewController",
            "Add device": "MyDevicesViewController",
            "Target" : "TargetViewController",
            "Language": "LanguageViewController",
            "Unit": "UnitViewController",
            "Date format": "DateFormateViewController",
            "Time format": "TimeFormateViewController",
            "First day of week": "FirstDayOfTheWeekViewController",
            "Logout": "LoginViewController",
            "Register online": "RegisterOnlineViewController"
        ]

        if let identifier = viewControllerMap[selectedItem] {
            
            if selectedItem == "Add device" {
                guard let AddDeviceVC = Navigation.shared.navigate(from: self, withIdentifier: "MyDevicesViewController") as? MyDevicesViewController else { return }
                AddDeviceVC.fromWhereItCame = "SettingsViewController"
            }
           else if selectedItem == "Logout" {
                Utilities.showAlert(on: self, title: "Logout", message: "Are you sure you want to logout?",isSuccess: true) {
                    Navigation.shared.navigate(from: self, withIdentifier: "LoginViewController")
                }
            }
            else if selectedItem == "Register online" {
                let sheet = UIAlertController(title: "Register Online", message: nil, preferredStyle: .actionSheet)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let newUser = UIAlertAction(title: "New User", style: .default) { _ in
                    Navigation.shared.navigate(from: self, withIdentifier: "EmailPasswordViewController")
                }
                let existingUser = UIAlertAction(title: "Existing User", style: .default) { _ in
                    Navigation.shared.navigate(from: self, withIdentifier: "LoginViewController")
                }
                
                sheet.addAction(newUser)
                sheet.addAction(existingUser)
                sheet.addAction(cancelAction)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    SideMenuManager.shared.closeSideMenu()
                }
                self.present(sheet, animated: true)
            }
            else{
                Navigation.shared.navigate(from: self, withIdentifier: identifier)
            }

        } else {
            print(
                "No valid ViewController or Link for selected item: \(selectedItem)"
            )
        }
    }

}
