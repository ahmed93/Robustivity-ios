//
//  BaseViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit



class BaseViewController: UIViewController {
    
    var delegate:AppDelegate!
    
    var wantsUserCheckInStatus = false
    var wantsUserCheckInStatusMoreView = false
    var userStatusBarButtonItem:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarStyle()
        NSUserDefaults.standardUserDefaults().addObserver(self, forKeyPath: "checkedIn", options: .New, context: nil)
        // Add Left navigation item
        userStatusBarButtonItem = UIBarButtonItem(image: UIImage(named: "circle"), style: .Plain, target: self, action: nil)
        userStatusBarButtonItem.tag = 1500
        changeColor()
        
        if wantsUserCheckInStatus {
            self.navigationItem.leftBarButtonItem = userStatusBarButtonItem
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = Theme.viewControllerBackgroundColor()
        
    }
    
    func setNavigationBarStyle() {
        if let navigationController = self.navigationController {
            navigationController.navigationBar.tintColor    = Theme.whiteColor()
            navigationController.navigationBar.barTintColor = Theme.statusBarColor()
            //        navigationController.navigationBar.translucent  = true
            navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : Theme.whiteColor()]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dissmissKeyboard() {
        self.view.endEditing(true)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "checkedIn" {
            changeColor()
        }
    }
    
    func changeColor() {
        if NSUserDefaults.standardUserDefaults().boolForKey("checkedIn") {
            userStatusBarButtonItem.tintColor = Theme.greenColor()
        }else {
            userStatusBarButtonItem.tintColor = Theme.grayColor()
            
        }
    }
    
}