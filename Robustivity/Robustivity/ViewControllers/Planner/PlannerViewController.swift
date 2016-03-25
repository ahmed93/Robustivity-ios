//
//  PlannerViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class PlannerViewController: BaseViewController {

    var segments:UISegmentedControl!
    var segmentControl:UISegmentedControl?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("PlannerViewController", owner: self, options: nil)
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        segmentControl = UISegmentedControl(items: ["test","newTest"])
//        segmentControl?.tintColor = Theme.whiteColor()
//        segmentControl?.selectedSegmentIndex = 0
//        segmentControl?.addTarget(self, action: NSSelectorFromString("valueChange:"), forControlEvents: .ValueChanged)
//        self.navigationItem.titleView = segmentControl
//
//    }
}