//
//  NotificationsTableViewCell.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/28/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: RBLabel!
    @IBOutlet weak var titleLabel: RBLabel!
    @IBOutlet weak var timeLabel: RBLabel!
    @IBOutlet weak var notificationImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
