//
//  HomeViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 06/03/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var editBtn: UIButton!
    var dataArray = [
        ("Scale", "111.11"),
        ("Blood Pressure", "111/111"),
        ("Activity", "11,111"),
        ("Sleep", "11:11"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.isEditing = false
        editBtn.isExclusiveTouch = true


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

    @IBAction func edit(_ sender: UIButton) {
        self.sideView.alpha = 0.0

        myTableView.isEditing.toggle()
        let image =
            myTableView.isEditing
            ? UIImage(systemName: "checkmark")
            : UIImage(systemName: "gearshape.fill")
        editBtn.setImage(image, for: .normal)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath)
        -> Bool
    {
        return true
    }

    func tableView(
        _ tableView: UITableView, moveRowAt fromIndexPath: IndexPath,
        to toIndexPath: IndexPath
    ) {
        let movedItem = dataArray.remove(at: fromIndexPath.row)
        dataArray.insert(movedItem, at: toIndexPath.row)
        tableView.reloadData()
    }

    func tableView(
        _ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(
        _ tableView: UITableView,
        shouldIndentWhileEditingRowAt indexPath: IndexPath
    ) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let (title, value) = dataArray[indexPath.row]

        switch title {
        case "Scale":
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: "ScaleCell", for: indexPath) as! ScaleCell
            cell.configure(weight: value)
            return cell
        case "Blood Pressure":
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: "BloodPressureCell", for: indexPath)
                as! BloodPressureCell
            let values = value.split(separator: "/")
            cell.configure(
                systolic: String(values[0]), diastolic: String(values[1]))
            return cell
        case "Activity":
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: "ActivityCell", for: indexPath)
                as! ActivityCell
            cell.configure(steps: value)
            return cell
        case "Sleep":
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: "SleepCell", for: indexPath) as! SleepCell
            cell.configure(sleepDuration: value)
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        let (title, value) = dataArray[indexPath.row]
        print("Selected: \(title) - Value: \(value)")
    }
}
