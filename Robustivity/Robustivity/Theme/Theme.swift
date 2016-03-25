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
    case darkOrange = 0xDB4C32
    case orange     = 0xFF7C2A
}

enum Size: CGFloat {
    case tiny       = 11 // 22
    case small      = 12 // 24
    case regular    = 13 // 26
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
    static func darkOrangeColor() -> UIColor {
        return UIColor(hexValue: Color.darkOrange.rawValue)
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
    
    static func size(size:Size)->CGFloat {
        return size.rawValue
    }
    
    
    // MARK: Application UIFonts
//    static func getFont(font:Font, size:CGFloat)->UIFont {
//        return UIFont(name: self.font(font), size: size)!
//    }
    
    
    // MARK: Application Suitable Naming funcs
    static func tableBackgroundColor() -> UIColor {
        return lightGrayColor()
    }
    
    static func viewControllerBackgroundColor() -> UIColor {
        return whiteColor()
    }

    static func statusBarColor()-> UIColor {
        return Theme.redColor()
    }
    
    static func listBackgroundColor()-> UIColor {
        return Theme.lightGrayColor()
    }
    
    
    static func sampleHeaderLabel(label:UILabel) {
        customFontForLabel(label, font: font(.Bold), color: redColor(), size: size(.big))
    }
    
    static func customFontForLabel(label:UILabel, font:String, color:UIColor, size:CGFloat) {
        label.font =  UIFont(name: font, size: size)
        label.textColor = color
    }
}

