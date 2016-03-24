//
//  UILable+Theme.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit


extension UILabel {
        
    public override class func initialize() {
        super.initialize()

        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        // make sure this isn't a subclass
        if self !== UILabel.self {
            return
        }
        
        dispatch_once(&Static.token) {
            let originalSelector = Selector("setText:")
            let swizzledSelector = Selector("xxx_setText:")
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    func xxx_setText(text:String) {
        self.xxx_setText(text)
        print(self.tag)
        print(self.font.pointSize)
        if tag == 1000 {
            font = UIFont(name: "HelveticaNeue", size:50)
            textColor = .redColor()
        }else if tag == 3000 {
            print("In")
            font = UIFont(name: "HelveticaNeue-Bold", size: self.font.pointSize)
            textColor = .redColor()
        }
    }
}
