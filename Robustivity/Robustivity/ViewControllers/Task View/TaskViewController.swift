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

class TaskViewController: BaseViewController {

    @IBOutlet weak var bottomTableConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewUpper: UIView!
    var infoAdapter:TaskInfoAdapter!
    var updatesAdapter:TaskUpdatesAdapter!
    var footerView:UIView!
    @IBOutlet weak var table: UITableView!
    var customSC:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        commentButton.addTarget(self, action: nil, forControlEvents: .TouchUpInside)
        commentButton.frame = CGRectMake(UIScreen.mainScreen().bounds.width - 100, 0, 100, 51)
        footerView.addSubview(commentButton)
        
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width - commentButton.frame.width, height: 51))
        textfield.placeholder = "   Write Comment Here..."
        textfield.backgroundColor = Theme.whiteColor()
        footerView.addSubview(textfield)
        footerView.frame.origin.y = UIScreen.mainScreen().bounds.height - 100
        footerView.hidden = true
        self.view.addSubview(footerView)
        //bottomTableConstraint.constant = 52
        
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
            bottomTableConstraint.constant = 8
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
