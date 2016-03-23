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
        
        let destinationVC:UIViewController = self as UIViewController
        if let mainProtocol = NSProtocolFromString("ThemeViewControllerDelegate") where destinationVC.conformsToProtocol(mainProtocol) {

            if let navigationController = self.navigationController {
                navigationController.navigationBar.tintColor = Theme.redColor()
                navigationController.navigationBar.barTintColor = Theme.redColor()
                navigationController.navigationBar.tag = 3000
            }
            return
        }
        
        // adding right/left button for sideMenus
        if (self.presentingViewController == nil)
        {
            return;
        }
        

        
//        UIImage *backButtonImage = [nextViewController backButtonImage];
//        backButtonImage = [backButtonImage imageWithAlignmentRectInsets:UIEdgeInsetsMake(0, 0, -4, 0)];
//        navigationController.navigationBar.backIndicatorImage = backButtonImage;
//        navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;
//        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
//        nextViewController.navigationItem.backBarButtonItem = backButton;
    }
}