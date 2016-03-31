//
//  PersonTableViewCell.swift
//  Robustivity
//
//  Created by Mohammad Lotfy on 2016-03-30.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var name: RBLabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var position: RBLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        name.labelType = 3010
        position.labelType = 1000
        avatar.layer.borderWidth = 1.0
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = Theme.whiteColor().CGColor
        avatar.layer.cornerRadius = avatar.frame.size.width/2
        avatar.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
