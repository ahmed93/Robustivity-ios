//
//  ProjectSegmentedControlViewController.swift
//  Robustivity
//
//  Created by Nada Fadali on 4/1/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectSegmentedControlViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Robustivity Project"
        self.navigationItem.title = "Robustivity Project"
    }
    
    @IBAction func switchViews(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            // show info
        case 1:
            // show updates
        case 2:
            // show members
        default:
            break;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
