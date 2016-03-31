//
//  CustomProjectsListTableViewCell.swift
//  Robustivity
//
//  Created by Apple on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CustomProjectsListTableViewCell: UITableViewCell {

  
  @IBOutlet weak var projectLogoImageView: UIImageView!
  
  @IBOutlet weak var projectNameLabel: RBLabel!
  
  @IBOutlet weak var memberLabel: RBLabel!
  
  
  @IBOutlet weak var statusUIView: UIView!
  
  @IBOutlet weak var marginUIView: UIView!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
