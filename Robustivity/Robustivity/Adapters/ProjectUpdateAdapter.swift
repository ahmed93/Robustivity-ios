//
//  ProjectUpdateAdapter.swift
//  Robustivity
//
//  Created by Nada Fadali on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class ProjectUpdateAdapter: BaseTableAdapter {
    
    let realm = try! Realm()
    let preferences = NSUserDefaults.standardUserDefaults()
    
    var projectId:Int?
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // any extra stuff to be done
    }
    
    func setProjectID(projectId:Int) {
        self.projectId = projectId
        fetchItems()
    }
    
    func fetchItems() {
        
        if tableItems.count == 0  && projectId != nil {
            let url = "\(APIRoutes.PROJECTS_INDEX)\(self.projectId!)/updates"
            
            API.get(url, callback: { (success, response) in
                if(success){
                    //map the json object to the model and save them
                    let projectUpdates = Mapper<ProjectUpdate>().mapArray(response["comments"])
                    for projectUpdate in projectUpdates! {
                        projectUpdate.saveDb()
                        if (projectUpdate.updateContent != "")
                        {
                            self.tableItems.objects.insertObject(projectUpdate, atIndex: 0)
                        }
                    }
                    
                    self.tableView.reloadData()
                }
            })
            
//            tableItems = ListModel()
        }

        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(120)
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let productUpdateTableViewCell = cell as? ProjectUpdateTableViewCell
        
        let currentUpdateData = tableItems.objectAtIndex(indexPath.row) as! ProjectUpdate
        
        productUpdateTableViewCell?.userNameLabel.text = currentUpdateData.userName as String!
        
         productUpdateTableViewCell?.userAvatarImageView.sd_setImageWithURL(NSURL(string: "http://hr.staging.rails.robustastudio.com" + currentUpdateData.userAvatar));
        productUpdateTableViewCell?.userAvatarImageView.layer.cornerRadius = (productUpdateTableViewCell?.userAvatarImageView.frame.size.width)! / 2
        productUpdateTableViewCell?.userAvatarImageView.clipsToBounds = true

        productUpdateTableViewCell?.updateTimeLabel.text = self.calUpdateTimestamp(currentUpdateData.updateUpdatedAt)

        productUpdateTableViewCell?.updateContentLabel.text = currentUpdateData.updateContent as String!
    }
    
    // Function that calculates the update time
    // param: updated at timestamp
    // return: time string
    func calUpdateTimestamp(updateTime: String) -> String
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let now = NSDate()
        let updateTimeDate = formatter.dateFromString(updateTime)!
        
        let diffSeconds = now.timeIntervalSinceDate(updateTimeDate)
        
        if(diffSeconds <= 59 && diffSeconds > 0)
        {
            return String(format: "%.0f seconds ago", diffSeconds)
        }
        else {
            let diffMin = round(diffSeconds / 60)
            if(diffMin <= 59 && diffMin > 0)
            {
                return String(format: "%.0f mins ago", diffMin)
            }
            else {
                let diffHours = round(diffMin / 60)
                if(diffHours <= 24 && diffHours > 0)
                {
                    return String(format: "%.0f hrs ago", diffHours)
                }
                else {
                    let diffDays = round(diffHours / 24)
                    if(diffDays > 0) {
                        return String(format: "%.0f days ago", diffDays)
                    } else {
                        return "Just Now"
                    }
                }
            }
        }
    }
    
    // MARK - send update to backend
    func postUpdate(updateContentString: String)
    {
        var requestParams = [String: AnyObject]()
        requestParams["comment[content]"] =  updateContentString as String
        let url = "\(APIRoutes.PROJECTS_INDEX)\(self.projectId!)/updates"

        API.post(url, parameters: requestParams , callback:{
            (success, response) in
            
            if(success){
                let projectUpdate = Mapper<ProjectUpdate>().map(response["comment"])!
                
                    // set user image from shared preference
                    if self.preferences.objectForKey("picture_icon_url") != nil {
                        projectUpdate.userAvatar = self.preferences.objectForKey("picture_icon_url") as! String
                    }
                    
                    // set user name from shared preference
                    let userFirstName = self.preferences.objectForKey("first_name") as? String
                    let userLastName = self.preferences.objectForKey("last_name") as? String
                    if(userFirstName != nil){
                        projectUpdate.userName = userFirstName!
                    }
                    if(userLastName != nil){
                        projectUpdate.userName += " " + userLastName!
                    }
                    
                    self.tableItems.objects.insertObject(projectUpdate, atIndex: 0)
                    projectUpdate.saveDb()
                
                self.tableView.reloadData()
                
            }
            else{
                print("error \(response)")
            }
        })
        
//        self.reloadItems()
        
    }
    
    
//    // Function that creates the content of the update
//    // param: update nature
//    // return: update content message
//    func setUpdateContent(updateNature: String) -> String
//    {
//        if(updateNature == "created_task")
//        {
//            return "created task"
//        }
//        
//        if(updateNature == "edited_task")
//        {
//            return "edited task"
//        }
//        
//        if (updateNature == "added_comment")
//        {
//            return "commented on task"
//        }
//        
//        return "unknown"
//    }
    
}

