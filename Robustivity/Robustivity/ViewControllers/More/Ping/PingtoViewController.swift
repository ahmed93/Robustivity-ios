//
//  PingtoViewController.swift
//  Robustivity
//
//  Created by Almgohar on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class PingtoViewController: BaseViewController, UITextViewDelegate {
   
    @IBOutlet var textviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var remainingUsersLabel: UILabel!
    @IBOutlet var firstUserToPingConstraints: NSLayoutConstraint!
    @IBOutlet var secondUserToPingConstraint: NSLayoutConstraint!
    @IBOutlet var firstUserToPing: UIImageView!
    @IBOutlet var secondUserToPing: UIImageView!
    @IBOutlet var ButtonConstrains: NSLayoutConstraint!
    @IBOutlet var textView:UITextView?
    @IBOutlet var addUsersToPingButton:UIButton?
    var base = "http://hr.staging.rails.robustastudio.com"
    var placeholderText = "Write your message here..."
    var sendPingButton:UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: NSSelectorFromString("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: NSSelectorFromString("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        self.title = "Ping To";
        self.navigationItem.title = "Ping To"
        sendPingButton = UIBarButtonItem(title: "Send", style: UIBarButtonItemStyle.Plain, target: self, action: "sendPing")
        sendPingButton?.enabled = false
        self.navigationItem.rightBarButtonItem = sendPingButton
        
        self.textView!.text = placeholderText
        self.textView!.textColor = Theme.lightGrayColor()
        self.textView!.delegate = self
        
        remainingUsersLabel!.layer.cornerRadius = (remainingUsersLabel!.frame.size.width) / 2
        remainingUsersLabel!.clipsToBounds = true
        remainingUsersLabel!.layer.borderWidth = 2
        remainingUsersLabel!.layer.borderColor = Theme.grayColor().CGColor
    }
    
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            Ping.selectedUsers.removeAll()
        }
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
    
    override func viewWillAppear(animated: Bool) {
        addChosenUsers()
    }
    
    func sendPing() {
        let sentAlert = UIAlertController(title: "Success", message: "The ping has been sent.", preferredStyle: UIAlertControllerStyle.Alert)
        let errorAlert = UIAlertController(title: "Failure", message: "The ping was not sent, please try again later!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let confirmAction = UIAlertAction(
        title: "OK", style: UIAlertActionStyle.Default) { (action) in
            self.navigationController!.popViewControllerAnimated(true)
            Ping.selectedUsers.removeAll()

        }
        
        sentAlert.addAction(confirmAction)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in}))
        
        let body = textView?.text
        var requestParams = [String: AnyObject]()
        
        requestParams["body"] =  body! as String
        requestParams["recipient_ids[]"] = Array(Ping.selectedUsers.keys)
        API.post(APIRoutes.PING_CREATE, parameters: requestParams , callback:{
            (success, response) in
            
            if(success){
                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(sentAlert, animated: true, completion: nil)
            }else{
               UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(errorAlert, animated: true, completion: nil)            }
        })
        }
    
    
    @IBAction func chooseUsersToPing() {
        let controller = PingToUsersViewController(nibName: "PingToUsersViewController", bundle: nil)
        navigationController?.presentViewController(UINavigationController(rootViewController:controller), animated: true, completion: nil)
    }
    
    func addChosenUsers() {
        if(!Ping.selectedUsers.isEmpty) {
            firstUserToPing.sd_setImageWithURL(NSURL(string: "http://hr.staging.rails.robustastudio.com" + Ping.selectedUsers.first!.1))
            firstUserToPing.layer.cornerRadius = (firstUserToPing.frame.size.width) / 2
            firstUserToPing.clipsToBounds = true
            firstUserToPing.hidden = false
            ButtonConstrains.constant = 25
            firstUserToPingConstraints.constant = -40
            if(Ping.selectedUsers.count > 1) {
                secondUserToPing.sd_setImageWithURL(NSURL(string: "http://hr.staging.rails.robustastudio.com" + Ping.selectedUsers[Ping.selectedUsers.startIndex.advancedBy(1)].1))
                secondUserToPing.layer.cornerRadius = (secondUserToPing.frame.size.width) / 2
                secondUserToPing.clipsToBounds = true
                secondUserToPing.hidden = false
                ButtonConstrains.constant = 50
                remainingUsersLabel.hidden = true


                if(Ping.selectedUsers.count > 2) {
                    remainingUsersLabel.hidden = false
                    remainingUsersLabel.text = "+" + String(Ping.selectedUsers.count - 2)
                    ButtonConstrains.constant = 75
                    firstUserToPingConstraints.constant = 8
                }
            } else{
                secondUserToPing.hidden = true
                ButtonConstrains.constant = 25
                firstUserToPingConstraints.constant = -40

            }
            
        } else {
            firstUserToPing.hidden = true
            secondUserToPing.hidden = true
            ButtonConstrains.constant = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textViewDidBeginEditing(textview: UITextView) {
        if (textview.textColor == Theme.lightGrayColor() || textView!.text == placeholderText){
            textview.text = nil
            textview.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textview: UITextView) {
        if textview.text.isEmpty {
            textview.text = placeholderText
            sendPingButton?.enabled = false
            textview.textColor = UIColor.lightGrayColor()
        } else {
            if(Ping.selectedUsers.count > 0){
                sendPingButton?.enabled = true
            }
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
