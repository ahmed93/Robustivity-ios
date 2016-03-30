//
//  ConfirmToggleViewController.swift
//  Robustivity
//
//  Created by Aya Amr on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ConfirmToggleViewController: BaseViewController {

    @IBOutlet weak var toggledTimeLabel: RBLabel!
    @IBOutlet weak var todoTitle: UITextField!
    var toggledTime = "00:00:00";
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Toggle";
        self.navigationItem.title = "Toggle";
        self.todoTitle.becomeFirstResponder();
        self.toggledTimeLabel.text = toggledTime;

        // Do any additional setup after loading the view.
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
