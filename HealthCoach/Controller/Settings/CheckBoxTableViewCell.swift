//
//  CheckBoxTableViewCell.swift
//  HealthCoach
//
//  Created by Keval Thumar on 19/03/25.
//

import UIKit

class CheckBoxTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheckBoxOut: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
