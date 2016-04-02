//
//  ProfileTableViewCell.swift
//  Robustivity
//
//  Created by Nariman El-Samadoni AND Abdelrahman Sakr on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet var cellButton: UIButton!
    @IBOutlet var cellContent: UITextField!
    @IBOutlet var cellTitle: RBLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
