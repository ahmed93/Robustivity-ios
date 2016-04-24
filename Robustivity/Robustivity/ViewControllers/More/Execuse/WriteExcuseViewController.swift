//
//  WriteExcuseViewController.swift
//  Robustivity
//
//  Created by Abdelrahman Saad  on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class WriteExcuseViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        NSBundle.mainBundle().loadNibNamed("WriteExcuseViewController", owner: self, options: nil)
//    }
    
    override func loadView() {
        super.loadView()


        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.view.backgroundColor = Theme.lightGrayColor() // setting background color
    }
    
    override func viewDidLoad() { // setting title and bar buttons and placeholders
        super.viewDidLoad()
        self.title = "Write Excuse";
        self.navigationItem.title = "Write Excuse";
        let sendButton = UIBarButtonItem(title: "Send", style: UIBarButtonItemStyle.Plain, target: self, action: "sendExcuse")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelExcuse")
        self.navigationItem.rightBarButtonItem = sendButton
        self.navigationItem.leftBarButtonItem = cancelButton
        self.textView.text = "Write here your excuse"
        self.textView.textColor = Theme.grayColor()
        textView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func sendExcuse() {
        
    }
    
    func cancelExcuse() {  // this dismisses the view upon click on cancel bar button
        dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    
    func textViewDidBeginEditing(textview: UITextView) { // handle placeholder in text view
        if textview.textColor == Theme.grayColor() {
            textview.text = nil
            textview.textColor = Theme.blackColor()
        }
    }
    
    func textViewDidEndEditing(textview: UITextView) { // handle placeholder in text view
        if textview.text.isEmpty {
            textview.text = "Write here your excuse"
            textview.textColor = Theme.grayColor()
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

