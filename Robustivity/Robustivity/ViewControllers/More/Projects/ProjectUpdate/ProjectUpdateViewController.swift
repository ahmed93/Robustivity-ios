//
//  ProjectUpdateViewController.swift
//  Robustivity
//
//  Created by Nada Fadali on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectUpdateViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var projectUpdateTableView: UITableView!
    
    @IBOutlet weak var newUpdateTextView: UITextView!
    let placeholderText = "Write Comment here"
    
    @IBOutlet weak var textAreaBottomConstraint: NSLayoutConstraint!
    
    var adapter: ProjectUpdateAdapter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Project Updates"
        self.navigationItem.title = "Project Update"
        
        // place holder
        self.newUpdateTextView.text = placeholderText
        self.newUpdateTextView.textColor = Theme.lightGrayColor()
        newUpdateTextView.delegate = self
        
        adapter = ProjectUpdateAdapter(viewController: self, tableView: projectUpdateTableView, registerCellWithNib:"ProjectUpdateTableViewCell", withIdentifier: "projectUpdate Cell")
        
//        // observer for keyboard
        NSNotificationCenter.defaultCenter().addObserver(self, selector:NSSelectorFromString("keyboardWillAppear:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:NSSelectorFromString("keyboardWillDisappear:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func setProjectID(pid:Int) {
        adapter.setProjectID(pid)
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        NSBundle.mainBundle().loadNibNamed("ProjectUpdateViewController", owner: self, options: nil)
//    }
    
    override func loadView() {
        super.loadView()
    }
    
    // MARK - send update to backend
    @IBAction func submitUpdate(sender: UIButton) {
        
        let newUpdateText = self.newUpdateTextView.text
        if ( newUpdateText != self.placeholderText && newUpdateText != "" )
        {
            adapter.postUpdate(newUpdateText)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.projectUpdateTableView.reloadData()
            })
            
            self.newUpdateTextView.endEditing(true)
            self.newUpdateTextView.text = placeholderText
            self.newUpdateTextView.textColor = Theme.lightGrayColor()
        }
        else{
            print("empty comment")
        }
    }
    
    // MARK - handle placeholder
    func textViewDidBeginEditing(textview: UITextView) {
        if textview.textColor == Theme.lightGrayColor() {
            textview.text = ""
            textview.textColor = Theme.blackColor()
        }
    }
    
    func textViewDidEndEditing(textview: UITextView) {
        if textview.text.isEmpty {
            textview.text = placeholderText
            textview.textColor = Theme.lightGrayColor()
        }
    }
    
    
    // MARK - keyboard observer
    func keyboardWillAppear(notification: NSNotification){
        // update constraint
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        let keyboardHeight = keyboardRectangle.height
        
        print(self.textAreaBottomConstraint.constant)
        self.textAreaBottomConstraint.constant  = ((-1*keyboardHeight)+70)
        print(self.textAreaBottomConstraint.constant)
    }
    
    func keyboardWillDisappear(notification: NSNotification){
        // update constraint
        self.textAreaBottomConstraint.constant = 0
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
