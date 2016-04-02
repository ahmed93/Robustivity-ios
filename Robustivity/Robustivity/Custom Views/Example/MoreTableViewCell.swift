//
//  MoreTableViewCell.swift
//  Robustivity
//
//  Created by Mayar ElMohr, Salma Amr, Nouran Mamdouh on 3/31/16.

//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
