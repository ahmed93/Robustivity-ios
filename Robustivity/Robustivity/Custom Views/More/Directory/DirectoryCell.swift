//
//  DirectoryCell.swift
//  Robustivity
//
//  Created by MacBook Pro on 3/28/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class DirectoryCell: UITableViewCell {
    
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTitle: RBLabel!
    @IBOutlet weak var userName: RBLabel!
    
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
