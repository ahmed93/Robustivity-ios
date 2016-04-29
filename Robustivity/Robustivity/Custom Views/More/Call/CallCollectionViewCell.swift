//
//  CallCollectionViewCell.swift
//  Robustivity
//
//  Created by Ali Soliman on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CallCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: RBLabel!
    
    @IBOutlet var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.labelType = 1000
        self.nameLabel.loadStyle()
        
    }

}
