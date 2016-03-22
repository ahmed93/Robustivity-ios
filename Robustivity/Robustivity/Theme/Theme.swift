//
//  Theme.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class Theme: NSObject {
    
    // MARK: Application Main Colors
    static func redColor() -> UIColor {
        return UIColor(hexValue: 0xCC0000) // to be changed for the needed red
    }
    
    // MARK: Application Main Fonts
    static func headerFont() -> String {
        return "Cabin-BoldItalic" // to be changed for the needed red
    }
    
    static func topBarFont() -> String {
        return "Cabin-Italic" // to be changed for the needed red
    }
}

