//
//  DescriptionTableViewCell.swift
//  Robustivity
//
//  Created by Mohammad Lotfy on 2016-03-30.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

/*
Custom cell for description in task info view
*/

import UIKit

class DescriptionTableViewCell: UITableViewCell {

   
    @IBOutlet weak var taskDescription: RBLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        taskDescription.labelType = 1030
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
