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
        print("Medication button tapped")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SideMenuManager.shared.closeSideMenu()
        }
    }

    @IBAction func btnHomeSide(_ sender: UIButton) {
        print("Home button tapped")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SideMenuManager.shared.closeSideMenu()
        }
    }

    @IBAction func btnMoreSide(_ sender: UIButton) {
        print("More button tapped")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SideMenuManager.shared.closeSideMenu()
        }
    }

    @IBAction func btnSettingsSide(_ sender: UIButton) {
        print("Settings button tapped")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            SideMenuManager.shared.closeSideMenu()
        }
    }

    @IBOutlet weak var tableView: UITableView!

    let sections = [
        ["Synchronisation", "About", "Export", "Rate the App"],
        ["Send feedback", "FAQ", "App Tour"],
        ["Imprint", "Terms and Conditions", "Data protection", "Disclaimer"],
    ]

}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MoreCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = sections[indexPath.section][indexPath.row]
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

    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        print("Selected: \(sections[indexPath.section][indexPath.row])")
    }
}
