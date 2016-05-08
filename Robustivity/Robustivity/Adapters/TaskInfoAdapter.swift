//
//  TaskInfoAdapter.swift
//  Robustivity
//
//  Created by Mohammad Lotfy on 2016-03-30.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

/*
Table adapter for the task info view
extends the BaseTableAdapter via multipleNibs constructor
returns two cell types: UserCell and DescriptionCell
*/

import UIKit
import ObjectMapper
import RealmSwift

class TaskInfoAdapter: BaseTableAdapter {
    var currentTask = TaskModel()
    var isActive = false
    
    override init(viewController: UIViewController, tableView: UITableView, registerMultipleNibsAndIdenfifers cellsNibs:NSDictionary) {
        super.init(viewController: viewController, tableView: tableView, registerMultipleNibsAndIdenfifers: cellsNibs)
        
        // any extra stuff to be done
    }
    
    func fetchItems() {
        let controller = self.viewController as! TaskViewController
            API.get(APIRoutes.TASKS_INDEX+controller.taskId, callback: { (success, response) in
                if(success){
                    //map the jason object to the model and save them
                   let responseDictionary = response as! Dictionary<String, AnyObject>
                    let taskz = responseDictionary["task"]
                    let task = Mapper<TaskModel>().map(taskz)
                    self.currentTask = task!
                //    self.tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, 4)), withRowAnimation: .None)
                    self.tableView.reloadData()
                        self.viewController.navigationItem.title = self.currentTask.taskName
                }
                else{
                    let toastLabel = UILabel(frame: CGRectMake(self.tableView.frame.size.width/2 - 150, self.tableView.frame.size.height-100, 300, 35))
                    toastLabel.backgroundColor = UIColor.blackColor()
                    toastLabel.textColor = UIColor.whiteColor()
                    toastLabel.textAlignment = NSTextAlignment.Center;
                    self.tableView.addSubview(toastLabel)
                    toastLabel.text = "Internal Server Error"
                    toastLabel.alpha = 1.0
                    toastLabel.layer.cornerRadius = 10;
                    toastLabel.clipsToBounds  =  true
//                    UIView.animateWithDuration(4.0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
//                        toastLabel.alpha = 0.0
//                        }, completion: nil)
                }
            })
    }
    
    func toggleTimer(timer: NSTimer, didUpdateTimerWithValue: String) {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TaskInfoToggledTableViewCell
        let toggleHelper = ToggleManager.sharedInstance
        //update cell of running task only
//        if(cell.toggleCellTask.taskId == toggleHelper.toggledTask!.taskId) {
//            cell.timer.text = didUpdateTimerWithValue
//
//        }
    }
    
    func toggleTimer(timer: NSTimer, didStartTimer: String) {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TaskInfoToggledTableViewCell
        let toggleHelper = ToggleManager.sharedInstance
//        if(cell.toggleCellTask.taskId == toggleHelper.toggledTask!.taskId) {
//            cell.playButtonCellSetup()
//        }
        
    }

    func toggleTimer(timer: NSTimer, didPauseTimer: Bool) {
        if(didPauseTimer) {
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! TaskInfoToggledTableViewCell
            let toggleHelper = ToggleManager.sharedInstance
//            if(cell.toggleCellTask.taskId == toggleHelper.toggledTask!.taskId) {
//                cell.pauseButtonCellSetup()
//                
//            }
            
        }
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath == 0 {
            return 80
        }
        else{
            return UITableViewAutomaticDimension
        }
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? BaseTableViewCell
        
        _cell?.label.text = tableItems.objectAtIndex(indexPath.row) as? String
    }

    override func configureViaMultipleIdentifiers(indexPath:NSIndexPath)->UITableViewCell? {
        if indexPath.section == 0 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("toggleCell", forIndexPath: indexPath)
                as! TaskInfoToggledTableViewCell
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle
            let x:String
            if let date = currentTask.taskStartDate {
                x = dateFormatter.stringFromDate(date)
            } else {
                x = ""
            }

            cell.timer.text = ToggleManager.sharedInstance.stringFromTimeInterval(Double(currentTask.taskDuration))
            cell.taskName.text = currentTask.taskName
            cell.taskDate.text = x
            cell.toggleCellTask = currentTask
            // Fix cell swipe actions
            if TaskInfoToggledTableViewCell.pauseButtonCellConfiguration().contains(currentTask.taskStatus) {
                cell.playButtonCellSetup()
            } else {
                cell.pauseButtonCellSetup()
            }
            return cell
        }
        else if indexPath.section == 1{
             let cell = self.tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
                as! UserTableViewCell
            
            let CUSTOM_BASE:String = "http://hr.staging.rails.robustastudio.com/"
            
                let url = NSURL(string: CUSTOM_BASE + currentTask.creatorAvatar)
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.userAvatar.image = UIImage(data: data!)
                    });
                
            }
            if(currentTask.creatorName.isEmpty){
                cell.userName.text = "Unknown task creator name"
            }
            else{
                cell.userName.text = self.currentTask.creatorName
            }
            if currentTask.creatorTitle.isEmpty{
                cell.userTitle.text = "Unknown Title"
            }
            else{
                cell.userTitle.text = currentTask.creatorTitle
            }
            cell.cellSeparator.hidden = true
        
        return cell
        
       }
        else if indexPath.section == 2 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
                as! UserTableViewCell
            if(currentTask.userName.isEmpty){
                cell.userName.text = "Unknown user assignee name"
            }
            else{
               cell.userName.text = self.currentTask.userName
            }
            let CUSTOM_BASE:String = "http://hr.staging.rails.robustastudio.com/"
            let url = NSURL(string: CUSTOM_BASE + currentTask.userAvatar)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                dispatch_async(dispatch_get_main_queue(), {
                    cell.userAvatar.image = UIImage(data: data!)
                });
            }
            
            if(currentTask.userTitle.isEmpty){
                cell.userTitle.text = "Unknown Title"
            }
            else{
                cell.userTitle.text = currentTask.userTitle
            }
            cell.cellSeparator.hidden = true
            
            return cell
        }
        else{
            let cell = self.tableView.dequeueReusableCellWithIdentifier("descriptionCell", forIndexPath: indexPath)
                as! DescriptionTableViewCell
            if currentTask.taskDescription.isEmpty{
                cell.taskDescription.text = "No description for this task."
                
            }else{
             cell.taskDescription.text = currentTask.taskDescription
            }
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
 //for hiding the first section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
        return 1.0
        }
        return 45.0
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName = String()
        switch(section){
        case 0:
            sectionName =  ""
            break
        case 1:
            sectionName = "Assigned by"
            break
        case 2:
            sectionName = "Assigned to"
            break
        default:
            sectionName = "Description"
            break
        }
        return sectionName
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    func isValidIndexPath(indexpath: NSIndexPath)->Bool {
        if indexpath.section < self.tableView.numberOfSections {
            if indexpath.row < self.tableView.numberOfRowsInSection(indexpath.section) {
                return true
            }
            
        }
        return false
    }
    
}

extension TaskInfoAdapter : ToggleManagerDelegate {
    func toggleManager(toggleManager: ToggleManager, hasTask task: TaskModel?, toggledTime: String?) {
        
        let toggleCellIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        if task != nil && isValidIndexPath(toggleCellIndexPath) {
            let toggleCell = tableView.cellForRowAtIndexPath(toggleCellIndexPath) as! TaskInfoToggledTableViewCell
            print(toggleCell.toggleCellTask)

            if toggleCell.toggleCellTask.taskId != task?.taskId {
                self.isActive = false
                return
            }
            self.isActive = true
            toggleCell.taskName.text = task!.taskName
            toggleCell.timer.text = toggleManager.stringFromTimeInterval(Double((task?.taskDuration)!))
            // Fix cell swipe actions
            if TaskInfoToggledTableViewCell.pauseButtonCellConfiguration().contains(task!.taskStatus) {
                toggleCell.playButtonCellSetup()
            } else {
                toggleCell.pauseButtonCellSetup()
            }
            
        }
    }
    
    func toggleManager(toggleManager: ToggleManager, didChangeToggledTask task: TaskModel, toggledTime: String) {
        let toggleCellIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        if isValidIndexPath(toggleCellIndexPath) {
            let toggleCell = tableView.cellForRowAtIndexPath(toggleCellIndexPath) as! TaskInfoToggledTableViewCell
            print(toggleCell.toggleCellTask)
            if toggleCell.toggleCellTask.taskId != task.taskId {
                self.isActive = false
                return
            }
            self.isActive = true
            toggleCell.taskName.text = task.taskName
            toggleCell.timer.text = toggleManager.stringFromTimeInterval(Double((task.taskDuration)))
            // Fix cell swipe actions
            if TaskInfoToggledTableViewCell.pauseButtonCellConfiguration().contains(task.taskStatus) {
                toggleCell.playButtonCellSetup()
            } else {
                toggleCell.pauseButtonCellSetup()
            }
            
        }
    }
    
    func toggleManager(toggleManager: ToggleManager, didUpdateTimer value: String) {
        let toggleCellIndexPath = NSIndexPath(forRow: 0, inSection: 0)
//        print(self.isActive)

        if isValidIndexPath(toggleCellIndexPath) && self.isActive {
            let toggleCell = tableView.cellForRowAtIndexPath(toggleCellIndexPath) as! TaskInfoToggledTableViewCell
            toggleCell.timer.text = value
            
        }
    }
}
