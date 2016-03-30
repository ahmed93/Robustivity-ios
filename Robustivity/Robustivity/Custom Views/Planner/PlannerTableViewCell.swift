//
//  PlannerTableViewCell.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 3/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class PlannerTableViewCell: UITableViewCell {
    @IBOutlet weak var itemTitle:RBLabel!
    @IBOutlet weak var projectName:RBLabel!
    @IBOutlet weak var toggleTimer:RBLabel!
    @IBOutlet weak var dueDate:RBLabel!

    @IBOutlet weak var bottomCellLayoutConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
