//
//  FeedViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class FeedViewController: BaseViewController {

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("FeedViewController", owner: self, options: nil)
    }

    override func loadView() {
        super.loadView()
    }

    
    @IBOutlet weak var ddd: UILabel!
    @IBAction func asd(sender: AnyObject) {
     ddd.text = "asd"
    }

}
