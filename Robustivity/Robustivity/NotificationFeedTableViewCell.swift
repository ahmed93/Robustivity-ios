//
//  NotificationFeedTableViewCell.swift
//  Robustivity
//
//  Created by khaled elhossiny on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class NotificationFeedTableViewCell: BaseTableViewCell {

    @IBOutlet weak var notificationTextLabel: RBLabel!
    @IBOutlet weak var timeStampsLabel: RBLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
