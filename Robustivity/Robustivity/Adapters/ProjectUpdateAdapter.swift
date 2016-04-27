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
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // any extra stuff to be done
    }
    
    
    func fetchItems() {
        if tableItems.count == 0 {
            API.get(APIRoutes.PROJECT_UPDATE, callback: { (success, response) in
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
                    
                }
            })
            
            tableItems = ListModel()
        }

        tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(120)
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let productUpdateTableViewCell = cell as? ProjectUpdateTableViewCell
        
        let currentUpdateData = tableItems.objectAtIndex(indexPath.row) as! ProjectUpdate
        
        productUpdateTableViewCell?.userNameLabel.text = currentUpdateData.userName as String!
        
         productUpdateTableViewCell?.userAvatarImageView.sd_setImageWithURL(NSURL(string: "http://hr.staging.rails.robustastudio.com" + currentUpdateData.userAvatar));

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
        
        if(diffSeconds <= 59)
        {
            return String(format: "%.0f seconds ago", diffSeconds)
        }
        else {
            let diffMin = round(diffSeconds / 60)
            if(diffMin <= 59)
            {
                return String(format: "%.0f mins ago", diffMin)
            }
            else {
                let diffHours = round(diffMin / 60)
                if(diffHours <= 24)
                {
                    return String(format: "%.0f hrs ago", diffHours)
                }
                else {
                    let diffDays = round(diffHours / 24)
                    return String(format: "%.0f days ago", diffDays)
                }
            }
        }
    }
    
    // MARK - send update to backend
    func postUpdate(updateContentString: String)
    {
        var requestParams = [String: AnyObject]()
        requestParams["comments[content]"] =  updateContentString
        
        API.post(APIRoutes.PROJECT_UPDATE, parameters: requestParams , callback:{
            (success, response) in
            
            if(success){
                print (response)
            }
            else{
                print("error \(response)")
            }
        })
        
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

