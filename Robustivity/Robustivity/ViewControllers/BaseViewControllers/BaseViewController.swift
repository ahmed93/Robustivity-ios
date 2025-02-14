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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarStyle()
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
   
}