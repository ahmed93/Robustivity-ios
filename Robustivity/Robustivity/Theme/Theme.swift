//
//  Theme.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

enum Color: Int {
    case lightGray  = 0xE6E6E6
    case lightBlack = 0x494949
    case black      = 0x000000
    case gray       = 0x828282
    case green      = 0x32C62C
    case red        = 0xC30017
    case blue       = 0x3A95FF
    case purple     = 0x9013FE
    case orange     = 0xDB4C32
}

enum Size: CGFloat {
    case tiny       = 11 // 22
    case small      = 12 // 24
    case mediam     = 13 // 26
    case big        = 14 // 28
    case extraBig   = 15 // 30
    case Large      = 16 // 32
    case extraLarge = 17 // 34
}

enum Font: String {
    case Bold, BoldIt, It , SemiboldIt, BoldCond, Cond , Regular, BoldCondIt, CondIt, Semibold
}

class Theme: NSObject {

    // MARK: Application Main Colors
    static func lightGrayColor() -> UIColor {
        return UIColor(hexValue: Color.lightGray.rawValue)
    }
    static func lightBlackColor() -> UIColor {
        return UIColor(hexValue: Color.lightBlack.rawValue)
    }
    static func blackColor() -> UIColor {
        return UIColor(hexValue: Color.black.rawValue)
    }
    static func grayColor() -> UIColor {
        return UIColor(hexValue: Color.gray.rawValue)
    }
    static func greenColor() -> UIColor {
        return UIColor(hexValue: Color.green.rawValue)
    }
    static func redColor() -> UIColor {
        return UIColor(hexValue: Color.red.rawValue)
    }
    static func blueColor() -> UIColor {
        return UIColor(hexValue: Color.blue.rawValue)
    }
    static func purpleColor() -> UIColor {
        return UIColor(hexValue: Color.purple.rawValue)
    }
    
    static func orangeColor() -> UIColor {
        return UIColor(hexValue: Color.orange.rawValue)
    }
    static func whiteColor() -> UIColor {
        return UIColor(hexValue: 0xFFFFFF)
    }
    
    // MARK: Application Main Fonts
    static func font(font:Font)->String {
        return "MyriadPro-\(font.rawValue)"
    }
    
    
    // MARK: Application Suitable Naming func-Colors
    static func tableBackgroundColor() -> UIColor {
        return lightGrayColor()
    }
    
    static func viewControllerBackgroundColor() -> UIColor {
        return whiteColor()
    }

    static func statusBarColor()-> UIColor {
        return Theme.redColor()
    }
    
    
    static func customFontForLabel(label:UILabel, font:Font, color:Color, size:Size) {
        label.font =  UIFont(name: self.font(font), size: size.rawValue)
        label.textColor = UIColor(hexValue: color.rawValue)
    }
}

