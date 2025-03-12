//
//  MyDevicesViewController.swift
//  HealthCoach
//
//  Created by Keval Thumar on 05/03/25.
//

import UIKit

class MyDevicesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!  // ✅ Connect this from storyboard

    let devices = [
        "SAS75", "SBC53", "SBF70/SBF71", "SBF72", "SBF73", "SBM37", "SBM67",
    ]
    let rowHeight: CGFloat = 40
    let extraPadding: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorInset = .zero
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = rowHeight
        updateTableViewHeight()
        BluetoothManager.shared.checkBluetoothStatus { isOn in
            print("🔵 Bluetooth Status: \(isOn ? "ON" : "OFF")")
        }
    }

    @IBAction func continueBtn(_ sender: UIButton) {
        let HomeVC = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                    self.navigationController?.pushViewController(HomeVC, animated: true)
    }
    private func updateTableViewHeight() {
        let totalHeight = (rowHeight * CGFloat(devices.count)) + extraPadding
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: totalHeight)  // ✅ Set calculated height
        ])
    }
}

extension MyDevicesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return devices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "tablecell")
            as! MyDevicesTableViewCell
        var content = cell.defaultContentConfiguration()
        content.text = devices[indexPath.row]
        content.textProperties.font = .systemFont(ofSize: 18, weight: .medium)
        cell.contentConfiguration = content
        return cell
    }

    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        // Handle cell selection
        goToNextPage(indexPath: indexPath)
    }
    private func goToNextPage(indexPath: IndexPath) {
        BluetoothManager.shared.checkBluetoothStatus { isOn in
            if isOn {
                DispatchQueue.main.async {
                    self.navigateToSelectedDevice(indexPath: indexPath)
                }
            } else {
                DispatchQueue.main.async {
                    self.showBluetoothAlert()
                }
            }
        }
    }

    private func navigateToSelectedDevice(indexPath: IndexPath) {
        print("You selected cell \(indexPath.row)")
        switch indexPath.row {
        case 0:
            let SAS75VC =
                self.storyboard?.instantiateViewController(
                    identifier: "SAS75ViewController") as! SAS75ViewController
            self.navigationController?.pushViewController(
                SAS75VC, animated: true)
        case 1:
            let SBC53VC =
                self.storyboard?.instantiateViewController(
                    identifier: "SBC53SettingViewController")
                as! SBC53SettingViewController
            self.navigationController?.pushViewController(
                SBC53VC, animated: true)
        case 2:
            let SBF70_71VC =
                self.storyboard?.instantiateViewController(
                    identifier: "SBF70_71SettingViewController")
                as! SBF70_71SettingViewController
            self.navigationController?.pushViewController(
                SBF70_71VC, animated: true)
        case 3:
            let SBF72VC =
                self.storyboard?.instantiateViewController(
                    identifier: "SBF72SettingViewController")
                as! SBF72SettingViewController
            self.navigationController?.pushViewController(
                SBF72VC, animated: true)
        case 4:
            let SBF73VC =
                self.storyboard?.instantiateViewController(
                    identifier: "SBF73SettingViewController")
                as! SBF73SettingViewController
            self.navigationController?.pushViewController(
                SBF73VC, animated: true)
        case 5:
            let SBM37VC =
                self.storyboard?.instantiateViewController(
                    identifier: "SBM37SettingViewController")
                as! SBM37SettingViewController
            self.navigationController?.pushViewController(
                SBM37VC, animated: true)
        case 6:
            let SBM67VC =
                self.storyboard?.instantiateViewController(
                    identifier: "SBM67SettingViewController")
                as! SBM67SettingViewController
            self.navigationController?.pushViewController(
                SBM67VC, animated: true)
        default:
            print("Please Select Valid Device")
        }
    }

    private func showBluetoothAlert() {
        let alert = UIAlertController(
            title: "Bluetooth Required",
            message: "Please turn on Bluetooth to continue.",
            preferredStyle: .alert
        )

        // ✅ OK Button
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        // ✅ "Turn On" Button → Opens Bluetooth Settings
        alert.addAction(
            UIAlertAction(
                title: "Turn On", style: .default,
                handler: { _ in
                    if let url = URL(string: "App-Prefs:root=Bluetooth"),
                        UIApplication.shared.canOpenURL(url)
                    {
                        UIApplication.shared.open(
                            url, options: [:], completionHandler: nil)
                    }
                }))

        present(alert, animated: true, completion: nil)
    }

}
