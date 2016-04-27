//
//  PingtoViewController.swift
//  Robustivity
//
//  Created by Almgohar on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class PingtoViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView:UITextView?
    @IBOutlet weak var addUsersToPingButton:UIButton?
    var placeholderText = "Write your message here..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ping To";
        self.navigationItem.title = "Ping To"
        let sendPingButton = UIBarButtonItem(title: "Send", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PingtoViewController.sendPing))
        self.navigationItem.rightBarButtonItem = sendPingButton
        let cancelPingButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PingtoViewController.cancelPing))
        self.navigationItem.leftBarButtonItem = cancelPingButton
        self.textView!.text = placeholderText
        self.textView!.textColor = Theme.lightGrayColor()
        self.textView!.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        addChosenUsers()
    }
    
    func sendPing() {
        
    }
    
    func cancelPing() {  // this dismisses the view upon click on cancel bar button
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func chooseUsersToPing() {
        let controller = PingToUsersViewController(nibName: "PingToUsersViewController", bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func addChosenUsers() {
        if(!Ping.selectedUsersPics.isEmpty) {
            let y = self.addUsersToPingButton?.frame.minY
            var x = self.addUsersToPingButton?.frame.minX
            for userPic in Ping.selectedUsersPics {
                x = x! + 50
                let imageView = UIImageView()
                imageView.sd_setImageWithURL(NSURL(string: "http://hr.staging.rails.robustastudio.com" + userPic))
                imageView.frame = CGRect(x: x!, y: y!, width: 40, height: 40)
                imageView.layer.cornerRadius = (imageView.frame.size.width) / 2
                imageView.clipsToBounds = true
                view.addSubview(imageView)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textViewDidBeginEditing(textview: UITextView) {
        if textview.textColor == Theme.lightGrayColor() {
            textview.text = nil
            textview.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textview: UITextView) {
        if textview.text.isEmpty {
            textview.text = placeholderText
            textview.textColor = UIColor.lightGrayColor()
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
