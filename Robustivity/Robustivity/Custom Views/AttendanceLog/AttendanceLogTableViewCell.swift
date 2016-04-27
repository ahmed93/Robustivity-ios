//
//  AttendanceLogTableViewCell.swift
//  Robustivity
//
//  Created by Jihan Adel on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//
//  Edited by: Jihan Adel & Majd el shebokshy

import UIKit

class AttendanceLogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var corePercentage: activityIndicator!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkinLabel: UILabel!
    @IBOutlet weak var checkoutLabel: UILabel!
    @IBOutlet weak var reason: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        corePercentage.layer.cornerRadius = 0.5 * corePercentage.bounds.size.width;
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    
}
