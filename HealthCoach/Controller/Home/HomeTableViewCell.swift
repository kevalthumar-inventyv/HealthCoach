//
//  HomeTableViewCell.swift
//  HealthCoach
//
//  Created by Keval Thumar on 07/03/25.
//

import UIKit

class ScaleCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    

    func configure(weight: String) {
        iconImageView.image = UIImage(systemName: "scalemass")
        titleLabel.text = "Scale"
        valueLabel.text = weight
        unitLabel.text = "kg"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateAndTime.text = formatter.string(from: Date())
    }
}

class BloodPressureCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var systolicLabel: UILabel!
    @IBOutlet weak var diastolicLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!

    func configure(systolic: String, diastolic: String) {
        iconImageView.image = UIImage(systemName: "heart.fill")
        titleLabel.text = "Blood Pressure"
        systolicLabel.text = systolic
        diastolicLabel.text = diastolic
        unitLabel.text = "mmHg"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateAndTime.text = formatter.string(from: Date())
    }
}


class ActivityCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    func configure(steps: String) {
        iconImageView.image = UIImage(systemName: "figure.walk")
        titleLabel.text = "Activity"
        valueLabel.text = steps
        unitLabel.text = "Steps"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        date.text = formatter.string(from: Date())
    }
}

class SleepCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    func configure(sleepDuration: String) {
        iconImageView.image = UIImage(systemName: "bed.double.fill")
        titleLabel.text = "Sleep"
        valueLabel.text = sleepDuration
        unitLabel.text = "h:min"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        date.text = formatter.string(from: Date())
    }
}



