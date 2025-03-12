//
//  SBM37SettingViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 05/03/25.
//

import UIKit

class SBM67SettingViewController: UIViewController {

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addDeviceBtn(_ sender: UIButton) {
        let selectedUsers = users.enumerated().compactMap {
            selectedIndexes[$0.offset] == true ? $0.element : nil
        }

        if selectedUsers.isEmpty {
            Utilities.showAlert(
                on: self, title: "Error!",
                message: "At least one user must be selected!")
        } else {
            print("Selected Users: \(selectedUsers.joined(separator: ", "))")
            let HomeVC = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(HomeVC, animated: true)
        }
    }

    let users = ["User 1", "User 2", "User 3", "User 4"]
    var selectedIndexes: [Bool] = []  // ✅ Track selected users

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndexes = Array(repeating: false, count: users.count)  // ✅ Initialize with all false
    }

}

extension SBM67SettingViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "SBM67cell", for: indexPath)
            as! SBM67SettingTableViewCell
        cell.onTapOut.setTitle(users[indexPath.row], for: .normal)
        cell.isChecked = selectedIndexes[indexPath.row]
        cell.checkboxTapped = { [weak self] in
            self?.selectedIndexes[indexPath.row].toggle()
        }
        return cell
    }

}
