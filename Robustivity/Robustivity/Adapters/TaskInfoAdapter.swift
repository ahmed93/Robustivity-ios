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

class TaskInfoAdapter: BaseTableAdapter{
    var currentTaskInfo = "2464"
    var currentTask = TaskModel()
    var user = User()
    
    override init(viewController: UIViewController, tableView: UITableView, registerMultipleNibsAndIdenfifers cellsNibs:NSDictionary) {
        super.init(viewController: viewController, tableView: tableView, registerMultipleNibsAndIdenfifers: cellsNibs)
        
        // any extra stuff to be done
    }
    
    func fetchItems() {
        if tableItems.count == 0 {
            API.get(APIRoutes.TASKS_INDEX+currentTaskInfo, callback: { (success, response) in
                if(success){
                    //map the jason object to the model and save them
                   let responseDictionary = response as! Dictionary<String, AnyObject>
                    let taskz = responseDictionary["task"]
                    let task = Mapper<TaskModel>().map(taskz)
                    self.currentTask = task!
                    self.tableItems.addObject(task!)
                    self.tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, 4)), withRowAnimation: .Bottom)
                }
            })
            
//            //getting user
//            var uid = "\(currentTask.taskUserId)"
//            API.get(APIRoutes.USER_SHOW+uid, callback: { (success, response) in
//                if(success){
//                    //map the jason object to the model and save them
//                    let user = Mapper<User>().map(response)
//                    self.user = user!
//                    print (user?.userFirstName)
//                    self.tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, 4)), withRowAnimation: .Bottom)
//                }
//            })
            
            tableItems = ListModel()
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
            cell.timer.text = "05:22:12"
            cell.taskName.text = "Robustivity Project"
            cell.taskDate.text = "Oct 15,2015"
            return cell
        }
        else if indexPath.section == 1{
             let cell = self.tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
                as! UserTableViewCell
            
            cell.userName.text = "Mohamed Lotfy"
            cell.userTitle.text = "CEO and co-founder"
            cell.cellSeparator.hidden = true
        
        return cell
        
       }
        else if indexPath.section == 2 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
                as! UserTableViewCell
            cell.userName.text = self.currentTask.userName
            let CUSTOM_BASE:String = "http://hr.staging.rails.robustastudio.com/"
            
            let url = NSURL(string: CUSTOM_BASE + currentTask.userAvatar)
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                dispatch_async(dispatch_get_main_queue(), {
                    cell.userAvatar.image = UIImage(data: data!)
                });
            }
            
            cell.userTitle.text = "Senior Software Engineer"
            cell.cellSeparator.hidden = true
            
            return cell
        }
        else{
            let cell = self.tableView.dequeueReusableCellWithIdentifier("descriptionCell", forIndexPath: indexPath)
                as! DescriptionTableViewCell
            cell.taskDescription.text = currentTask.taskDescription
//            
//            cell.taskDescription.text = "I have a big task waiting I have a big task waiting I have a big task waiting \n I have a big task waitingI have a big task waitingI have a big task waiting"
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
    
}
