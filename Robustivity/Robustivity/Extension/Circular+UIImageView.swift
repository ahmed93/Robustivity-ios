//
//  Circular+UIImageView.swift
//  Robustivity
//
//  Created by khaled elhossiny on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
extension UIImageView{
    /*
    Made by Khaled Elhossiny
    this extension is for making the frame of the imageView circular
    */
    func makeCircular(){
        layer.cornerRadius = frame.size.width/2
        layer.masksToBounds = true
        layer.borderColor = Theme.whiteColor().CGColor
    }
}
