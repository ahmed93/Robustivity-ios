//
//  Theme.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

enum Color: Int {
    case lightGray    = 0xE6E6E6
    case gray         = 0x828282
    case lighterBlack = 0x494949
    case lightBlack   = 0x343434
    case black        = 0x000000
    case green        = 0x32C62C
    case red          = 0xC30017
    case blue         = 0x3A95FF
    case purple       = 0x9013FE
    case darkOrange   = 0xDB4C32
    case orange       = 0xFF7C2A
    case white        = 0xFFFFFF
}

enum Size: CGFloat {
    case tiny       = 11 // 22
    case small      = 12 // 24
    case regular    = 13 // 26
    case big        = 14 // 28
    case extraBig   = 15 // 30
    case large      = 16 // 32
    case extraLarge = 17 // 34
    case veryExBig  = 22 // 44
}

enum MyriadProFont: String {
    case bold           = "Bold"
    case boldItalic     = "BoldIt"
    case italic		    = "It"
    case semiboldItalic	= "SemiboldIt"
    case boldCond	    = "BoldCond"
    case cond 		    = "Cond"
    case regular	    = "Regular"
    case boldCondItalic	= "BoldCondIt"
    case condItalic		= "CondIt"
    case semiBold	    = "Semibold"
}

class Theme: NSObject {
    
    // MARK: Application Main Colors
    static func lightGrayColor() -> UIColor {
        return UIColor(hexValue: Color.lightGray.rawValue)
    }
    static func lighterBlackColor() -> UIColor {
        return UIColor(hexValue: Color.lighterBlack.rawValue)
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
        return UIColor(hexValue: Color.white.rawValue)
    }
    
    
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
    
    
    // MARK: Application FontStyles
    static func style_1(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.regular), color: getColor(.lightBlack), size: getSize(.big))
    }
    static func style_2(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.regular), color: getColor(.lightBlack), size: getSize(.small))
    }
    static func style_3(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.regular), color: getColor(.lighterBlack), size: getSize(.small))
    }
    static func style_4(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.regular), color: getColor(.lighterBlack), size: getSize(.big))
    }
    static func style_5(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.regular), color: getColor(.green), size: getSize(.veryExBig))
    }
    static func style_6(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.regular), color: getColor(.red), size: getSize(.big))
    }
    static func style_7(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.regular), color: getColor(.white), size: getSize(.regular))
    }
    static func style_8(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.regular), color: getColor(.black), size: getSize(.extraLarge))
    }
    static func style_9(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.regular), color: getColor(.gray), size: getSize(.tiny))
    }
    static func style_10(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.regular), color: getColor(.gray), size: getSize(.extraBig))
    }
    static func style_11(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.boldCond), color: getColor(.blue), size: getSize(.extraLarge))
    }
    static func style_12(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.semiBold), color: getColor(.lightBlack), size: getSize(.big))
    }
    static func style_13(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.semiBold), color: getColor(.lightBlack), size: getSize(.extraBig))
    }
    static func style_14(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.semiBold), color: getColor(.lightBlack), size: getSize(.extraLarge))
    }
    static func style_15(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.semiBold), color: getColor(.green), size: getSize(.small))
    }
    static func style_16(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.semiBold), color: getColor(.green), size: getSize(.large))
    }
    static func style_17(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.semiBold), color: getColor(.black), size: getSize(.small))
    }
    static func style_18(label:UILabel) {
        customFontForLabel(label,font: getMyriadProFont(.semiBold), color: getColor(.purple), size: getSize(.small))
    }
    
    
    // MARK: Other Uses
    static func getMyriadProFont(font:MyriadProFont)->String {
        return "MyriadPro-\(font.rawValue)"
    }
    
    static func getSize(size:Size)->CGFloat {
        return size.rawValue
    }
    
    static func getColor(color:Color)->UIColor {
        return UIColor(hexValue: color.rawValue)
    }
    
    static func customFontForLabel(label:UILabel, font:String, color:UIColor, size:CGFloat) {
        label.font =  UIFont(name: font, size: size)
        label.textColor = color
    }
    
}

