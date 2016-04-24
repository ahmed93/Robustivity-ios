//
//  RoundBorderedView.swift
//  Robustivity
//
//  Created by Mariam Mohamed on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class RoundBorderedView: UIView {
  
  /*
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect) {
  // Drawing code
  }
  */
  
  override func drawRect(rect: CGRect) {
    clipsToBounds = true;
    layer.cornerRadius = frame.size.height / 2;
  }
  
}

