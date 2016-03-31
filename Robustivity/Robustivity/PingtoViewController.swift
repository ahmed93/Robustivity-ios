//
//  PingtoViewController.swift
//  Robustivity
//
//  Created by Almgohar on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class PingtoViewController: BaseViewController {
    
 @IBOutlet weak var textView:UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ping To";
        self.navigationItem.title = "Ping To"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func textViewDidBeginEditing() {
        if self.textView!.textColor == UIColor.lightGrayColor() {
            self.textView!.text = nil
            self.textView!.textColor = UIColor.blackColor()
        }
    }
    
    @IBAction func textViewDidEndEditing() {
        if self.textView!.text.isEmpty {
            self.textView!.text = "Placeholder"
            self.textView!.textColor = UIColor.lightGrayColor()
        }
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
