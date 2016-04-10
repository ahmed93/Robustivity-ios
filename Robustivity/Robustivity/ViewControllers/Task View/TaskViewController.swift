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

    
    @IBOutlet weak var viewUpper: UIView!
    var infoAdapter:TaskInfoAdapter!
    var updatesAdapter:TaskUpdatesAdapter!
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
        customSC.frame.origin.y = customSC.frame.origin.y + 25
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
            table.reloadData()
            break
        case 1:
            table.separatorStyle = .None
            updatesAdapter = TaskUpdatesAdapter(viewController: self, tableView: table, registerCellWithNib: "CommentTableViewCell", withIdentifier: "commentCell")
            table.reloadData()
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
