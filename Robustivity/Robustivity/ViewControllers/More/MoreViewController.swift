//
//  MoreViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("MoreViewController", owner: self, options: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "More";
        self.navigationItem.title = "More";
    }

    
    @IBAction func gotoCallViewController(sender: AnyObject) {
        let callViewController = CallViewController(nibName: "CallViewController", bundle: nil) as CallViewController
        self.navigationController!.pushViewController(callViewController, animated: true)
    }
}
