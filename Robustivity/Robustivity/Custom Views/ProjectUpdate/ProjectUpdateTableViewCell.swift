//
//  ProjectUpdateTableViewCell.swift
//  Robustivity
//
//  Created by Nada Fadali on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectUpdateTableViewCell: BaseTableViewCell {

    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: RBLabel!
    
    
    @IBOutlet weak var updateTimeLabel: RBLabel!
    @IBOutlet weak var updateContentLabel: RBLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
