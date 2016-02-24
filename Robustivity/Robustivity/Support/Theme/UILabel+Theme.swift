//
//  UILabel.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import UIKit


extension UILabel {
    
//    class func setText(text:String) -> String {
//        
//        return "s";
//    }
    
//    @IBInspectable var labelType:Type = Type.Default
//    public override class func initialize() {
//        struct Static {
//            static var token: dispatch_once_t = 0
//        }
//        
//        // make sure this isn't a subclass
//        if self !== UILabel.self {
//            return
//        }
//        
//        dispatch_once(&Static.token) {
//            let originalSelector = Selector("setText")
//            let swizzledSelector = Selector("setText")
//            
//            if let klass: AnyClass = object_getClass(self) {
//                
//                let originalMethod = class_getClassMethod(klass, originalSelector)
//                let swizzledMethod = class_getClassMethod(klass, swizzledSelector)
//                
//                
//                let didAddMethod = class_addMethod(klass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//                
//                if didAddMethod {
//                    class_replaceMethod(klass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//                } else {
//                    method_exchangeImplementations(originalMethod, swizzledMethod);
//                }
//            }
//        }
//    }
//
//    // MARK: - Method Swizzling
//    class func lh_endpoint() -> String! {
//        let environmentDictionary = NSProcessInfo.processInfo().environment
//        if let endpoint = environmentDictionary["ENDPOINT"] as? String {
//            println("returning custom endpoint \(endpoint)")
//            return endpoint
//        }
//        return self.lh_endpoint()
//    }
}
