//
//  PingToUserTableViewCell.swift
//  Robustivity
//
//  Created by Almgohar on 4/2/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class PingToUserTableViewCell: UITableViewCell {

    @IBOutlet weak var pingUserName: UILabel!
    @IBOutlet weak var pingUserTitle: UILabel!
    @IBOutlet weak var pingUserAvatar: UIImageView!
    var userId:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
