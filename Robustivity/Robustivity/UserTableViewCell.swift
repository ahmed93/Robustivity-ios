//
//  UserTableViewCell.swift
//  Robustivity
//
//  Created by Mahmoud Eldesouky on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var cellSeparator: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cellSeparator.backgroundColor = Theme.lightGrayColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
