//
//  ProjectMemberCell.swift
//  Robustivity
//
//  Created by Abdelrahman Zaky on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectMemberCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: RBLabel!
    @IBOutlet weak var positionLabel: RBLabel!
    @IBOutlet weak var profileImageView: UIImageView!
     @IBOutlet weak var marginUIView: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
