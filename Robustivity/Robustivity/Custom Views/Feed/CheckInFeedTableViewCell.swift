//
//  CheckInFeedTableViewCell.swift
//  Robustivity
//
//  Created by khaled elhossiny on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CheckInFeedTableViewCell: BaseTableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var checkInTitleLabel: RBLabel!
    @IBOutlet weak var timeStampsLabel: RBLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setStyle()
        //avatarImageView.makeCircular()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setStyle(){
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
        self.avatarImageView.clipsToBounds = true;
        self.timeStampsLabel.labelType = 1080
        self.checkInTitleLabel.labelType = 3000
        
    }
    
}
