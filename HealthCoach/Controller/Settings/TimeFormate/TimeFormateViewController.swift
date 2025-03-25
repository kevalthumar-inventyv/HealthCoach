//
//  TimeFormateViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 18/03/25.
//

import UIKit

class TimeFormateViewController : UIViewController , UITableViewDelegate, UITableViewDataSource{
    let time = ["12-hours", "24-hours"]

    var selectedIndex: Int?  // Track selected row

    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! CheckBoxTableViewCell

        cell.btnCheckBoxOut.setTitle(time[indexPath.row], for: .normal)

        // Update checkbox state
        let isSelected = (selectedIndex == indexPath.row)
        let imageName = isSelected ? "checkmark.square.fill" : "square"
        cell.btnCheckBoxOut.setImage(UIImage(systemName: imageName), for: .normal)

        // Add target to handle button tap
        cell.btnCheckBoxOut.tag = indexPath.row
        cell.btnCheckBoxOut.addTarget(self, action: #selector(checkBoxTapped(_:)), for: .touchUpInside)

        return cell
    }

    @objc func checkBoxTapped(_ sender: UIButton) {
        let newIndex = sender.tag

        if selectedIndex == newIndex {
            selectedIndex = nil
        } else {
            selectedIndex = newIndex
        }

        myTableView.reloadData()
    }

    
    
    @IBAction func btnBack(_ sender: UIButton) {
        Navigation.shared.popViewController(from: self)
    }
}
