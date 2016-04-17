//
//  TaskViewController.swift
//  Robustivity
//
//  Created by Mohammad Lotfy on 2016-03-30.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

/*
 view controller for the task view
 extends the BaseViewController
 Adds a Segmented control to the navigation bar to move between task info and task updates
 */

import UIKit

class TaskViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bottomTableConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewUpper: UIView!
    var infoAdapter:TaskInfoAdapter!
    var updatesAdapter:TaskUpdatesAdapter!
    var footerView:UIView!
    var textfield:UITextField!
    @IBOutlet weak var table: UITableView!
    var customSC:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        let dic:NSDictionary = [
            "UserTableViewCell" : "userCell"
            ,   "DescriptionTableViewCell" : "descriptionCell",
                "TaskInfoToggledTableViewCell":"toggleCell"]
        infoAdapter = TaskInfoAdapter(viewController: self, tableView: table, registerMultipleNibsAndIdenfifers: dic)
        self.table.backgroundColor = Theme.lightGrayColor()
        self.automaticallyAdjustsScrollViewInsets = false
        
        footerView = UIView(frame:CGRectMake(0,0,320,40))
        footerView.backgroundColor = Theme.lightGrayColor()
        let commentButton = UIButton(type: .Custom)
        commentButton.setTitle("Comment", forState: .Normal)
        Theme.style_11(commentButton.titleLabel!)
        commentButton.setTitleColor(Theme.blueColor(), forState: .Normal)
        commentButton.backgroundColor = Theme.whiteColor()
        commentButton.addTarget(self, action: "addComment:", forControlEvents: .TouchUpInside)
        commentButton.frame = CGRectMake(UIScreen.mainScreen().bounds.width - 100, 0, 100, 51)
        footerView.addSubview(commentButton)
        
        textfield = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width - commentButton.frame.width, height: 51))
        textfield.placeholder = "Write Comment Here..."
        textfield.backgroundColor = Theme.whiteColor()
        let paddingView = UIView(frame:CGRectMake(0, 0, 25, 25))
        textfield.leftView=paddingView;
        textfield.leftViewMode = UITextFieldViewMode.Always
        textfield.delegate = self
        footerView.addSubview(textfield)
        footerView.frame.origin.y = UIScreen.mainScreen().bounds.height - 100
        footerView.hidden = true
        self.view.addSubview(footerView)
        bottomTableConstraint.constant = 52
        
    }
    
    override func loadView() {
        super.loadView()
        let items = ["Info", "Updates"]
        customSC = UISegmentedControl(items:items)
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = Theme.redColor()
        customSC.tintColor = UIColor.whiteColor()
        customSC.selectedSegmentIndex = 0
        
        let frame = UIScreen.mainScreen().bounds
        customSC.frame = CGRectMake(frame.minX + 10, frame.minY + 50,
                                                     frame.width - 140, 30)
        customSC.center = self.viewUpper.center
        customSC.frame.origin.y = customSC.frame.origin.y + 30
        viewUpper.addSubview(customSC)
        customSC.addTarget(self, action: "tabChanged:", forControlEvents: .ValueChanged)
        
        viewUpper.backgroundColor = self.navigationController?.navigationBar.barTintColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let taskName = RBLabel()
        taskName.textAlignment = NSTextAlignment.Center
        taskName.text = "Task 1"
        taskName.labelType = 1000
        taskName.textColor = Theme.whiteColor()
        self.view.addSubview(taskName)
        self.navigationItem.title =  "iOS Front END part 2"
        
    }
    
    func addComment(sender:UIButton!){
        self.updatesAdapter.tableData.append(textfield.text!)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.table.reloadData()
        })
        textfield.text = nil
        view.endEditing(true)
    }
    
    func tabChanged(sender:UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            table.separatorStyle = .None
            let dic:NSDictionary = [
                "UserTableViewCell" : "userCell"
                ,   "DescriptionTableViewCell" : "descriptionCell",
                    "TaskInfoToggledTableViewCell":"toggleCell"]
            infoAdapter = TaskInfoAdapter(viewController: self, tableView: table, registerMultipleNibsAndIdenfifers: dic)
            footerView.hidden = true
            
            bottomTableConstraint.constant = 50
            self.view.layoutIfNeeded()
            table.reloadData()
            break
        case 1:
            table.separatorStyle = .None
            updatesAdapter = TaskUpdatesAdapter(viewController: self, tableView: table, registerCellWithNib: "CommentTableViewCell", withIdentifier: "commentCell")
            table.reloadData()
            footerView.hidden = false
            bottomTableConstraint.constant = 100
            self.view.layoutIfNeeded()
            break
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -195
        //self.bottomTableConstraint.constant = 150
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.updatesAdapter.tableData.append(textfield.text!)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.table.reloadData()
        })
        textfield.text = nil
        textfield.resignFirstResponder()
        return true
    }
}
