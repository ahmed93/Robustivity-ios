//
//  BroadcastFeedTableViewCell.swift
//  Robustivity
//
//  Created by khaled elhossiny on 3/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class BroadcastFeedTableViewCell: BaseTableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var broadcastTitleLabel: RBLabel!
    
    @IBOutlet weak var timestampsLabel: RBLabel!
    @IBOutlet weak var broadcastTextLabel: RBLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabelsStyle()
        avatarImageView.makeCircular()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabelsStyle(){
        self.timestampsLabel.labelType = 1080
        self.broadcastTextLabel.labelType = 1020
        self.broadcastTitleLabel.labelType = 3000
        
    }
    
}
