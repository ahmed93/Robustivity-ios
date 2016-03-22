//
//  UIViewController+Theme.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        if self !== UILabel.self {
            
        }
        
        // make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }
        
        dispatch_once(&Static.token) {
            let originalSelector = Selector("viewWillAppear:")
            let swizzledSelector = Selector("xxx_viewWillAppear:")
            
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
    
    // MARK: - Method Swizzling
    func xxx_viewWillAppear(animated: Bool) {
        self.xxx_viewWillAppear(animated)
        
        let navigationController = self.navigationController
        if navigationController == nil {
            return
        }
        self.navigationController!.navigationBar.tintColor = Theme.redColor()
        self.navigationController!.navigationBar.barTintColor = Theme.redColor()
        self.navigationController?.navigationBar.tag = 3000
        
        // adding right/left button for sideMenus
    }
}