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
import ObjectMapper
import RealmSwift

class TaskViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bottomTableConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewUpper: UIView!
    var infoAdapter:TaskInfoAdapter!
    var updatesAdapter:TaskUpdatesAdapter!
    var tableAdapter:BaseTableAdapter!
    var footerView:UIView!
    var textfield:UITextField!
    @IBOutlet weak var table: UITableView!
    var customSC:UISegmentedControl!
    var taskId:String!
    let preferences = NSUserDefaults.standardUserDefaults()
    let toggleManager = ToggleManager.sharedInstance

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSegmentControl()
        addFooterView()
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
//        self.toggleHelper.taskInfoViewDelegate = self.infoAdapter

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
//        self.toggleHelper.timerDelegate = self.infoAdapter // Assuty

    }
    
    override func loadView() {
        super.loadView()
    }
    
    func addFooterView() {
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
    
    func addSegmentControl(){
        let items = ["Info", "Updates"]
        customSC = UISegmentedControl(items:items)
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = Theme.redColor()
        customSC.tintColor = UIColor.whiteColor()
        customSC.selectedSegmentIndex = 0
        
        let frame = UIScreen.mainScreen().bounds
        customSC.frame = CGRectMake(frame.minX + 10, frame.minY + 50,
                                                     frame.width - 140, 30)
        customSC.frame.origin.y = customSC.frame.origin.y + 10
        customSC.frame.origin.x = viewUpper.frame.size.width/4
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
    }
    
    func addToast(text:NSString){
        let toastLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height-100, 300, 35))
        toastLabel.backgroundColor = UIColor.blackColor()
        toastLabel.textColor = UIColor.whiteColor()
        toastLabel.textAlignment = NSTextAlignment.Center;
        self.view.addSubview(toastLabel)
        toastLabel.text = text as String
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
  //      UIView.animateWithDuration(4.0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
    //        toastLabel.alpha = 0.0
    //        }, completion: nil)
    }
    
    func addComment(sender:UIButton!){
        let commentText = textfield.text
        if (commentText!.isEmpty){
            self.addToast("Empty comment")
        }else{
            let comment  = ["comment[content]" : commentText]
            
            API.post(APIRoutes.TASKS_INDEX + self.taskId + "/updates", parameters: comment as! [String : String], callback:{
                (success, response) in
                if(success){
                    let comment = Mapper<TaskCommentModel>().map(response["comment"])!
                    if(comment.userName == "") {
                        comment.userName = (self.preferences.objectForKey("first_name") as? String)! + (self.preferences.objectForKey("last_name") as? String)!
                    }
                    
                    if(comment.userProfilePicture == "") {
                        comment.userProfilePicture = self.preferences.objectForKey("picture_icon_url") as! String

                    }
                    self.updatesAdapter.tableItems.objects.insertObject(comment, atIndex: 0)
                    self.table.reloadData()

                    self.textfield.text = nil
                    self.view.endEditing(true)
                }else{
                    self.addToast("Request Failed")
                }

            })
        }
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
        let userInfo:NSDictionary = sender.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        let keyboardHeight = keyboardRectangle.height
        self.view.frame.origin.y = -keyboardHeight + 50
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
        //self.updatesAdapter.tableData.append(textfield.text!)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.table.reloadData()
        })
        textfield.text = nil
        textfield.resignFirstResponder()
        return true
    }
}
