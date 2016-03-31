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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
