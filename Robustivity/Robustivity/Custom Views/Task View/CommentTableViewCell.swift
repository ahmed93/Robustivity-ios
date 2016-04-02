//
//  CommentTableViewCell.swift
//  Robustivity
//
//  Created by Mohammad Lotfy on 2016-03-31.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

/*
Custom cell for the comment in task updates view
*/

import UIKit
class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var comment: RBLabel!
    @IBOutlet weak var name: RBLabel!
    @IBOutlet weak var time: RBLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        comment.labelType = 1030
        time.labelType = 1080
        name.labelType = 3020
        
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
