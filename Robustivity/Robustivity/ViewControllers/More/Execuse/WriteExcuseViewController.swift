//
//  WriteExcuseViewController.swift
//  Robustivity
//
//  Created by Abdelrahman Saad  on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class WriteExcuseViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet var textviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    var sendButton:UIBarButtonItem?
    override func loadView() {
        super.loadView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.view.backgroundColor = Theme.lightGrayColor() // setting background color
    }
    
    override func viewDidLoad() { // setting title and bar buttons and placeholders
        super.viewDidLoad()
        let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        self.title = "Write Excuse";
        self.navigationItem.title = "Write Excuse";
         sendButton = UIBarButtonItem(title: "Send", style: UIBarButtonItemStyle.Plain, target: self, action: "sendExcuse")
        self.sendButton?.enabled = false
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelExcuse")
        self.navigationItem.rightBarButtonItem = sendButton
        self.navigationItem.leftBarButtonItem = cancelButton
        self.textView.text = "Write here your excuse"
        self.textView.textColor = Theme.grayColor()
        textView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        let info:NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        
        let keyboardHeight: CGFloat = keyboardSize.height
        
        self.textviewHeightConstraint.constant = keyboardHeight + 20
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.textviewHeightConstraint.constant = 0
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func sendExcuse() {    // here the post request is being called when the sendExcuse button is pressed
        let sentAlert = UIAlertController(title: "Success", message: "Your excuse has been sent.", preferredStyle: UIAlertControllerStyle.Alert)
        let errorAlert = UIAlertController(title: "Failure", message: "The excuse was not sent, please try again", preferredStyle: UIAlertControllerStyle.Alert)
        let emptyAlert = UIAlertController(title: "Empty", message: "Sorry, you cannot send an empty excuse.", preferredStyle: UIAlertControllerStyle.Alert)
        sentAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.dismissViewControllerAnimated(true, completion: nil);
        }))
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        emptyAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        let excuseBody = self.textView.text
        var params = [String: AnyObject]()
        params["excuse[body]"] = excuseBody
        if(excuseBody != "" && self.textView.textColor != Theme.grayColor()) {
            API.post(APIRoutes.EXCUSES_CREATE, parameters: params, callback:{
                (success, response) in
                if(success){
                    self.presentViewController(sentAlert, animated: true, completion: nil)
                    //self.dismissViewControllerAnimated(true, completion: nil);
                }
                else {
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                    //self.dismissViewControllerAnimated(true, completion: nil);
                }
            })
        }
        else {
            self.presentViewController(emptyAlert, animated: true, completion: nil)
        }
    }
    
    func cancelExcuse() {  // this dismisses the view upon click on cancel bar button
        dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    
    func textViewDidBeginEditing(textview: UITextView) { // handle placeholder in text view
        if textview.textColor == Theme.grayColor() {
            textview.text = nil
            textview.textColor = Theme.blackColor()
            self.sendButton?.enabled = true
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

