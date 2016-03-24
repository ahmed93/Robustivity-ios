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
    
    override func loadView() {
        super.loadView()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("dissmissKeyboard")))
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = Theme.viewControllerBackgroundColor()
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.tintColor    = Theme.statusBarColor()
            navigationController.navigationBar.barTintColor = Theme.statusBarColor()
            navigationController.navigationBar.translucent = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dissmissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    
   
}