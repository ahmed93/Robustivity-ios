//
//  TaskUpdatesAdapter.swift
//  Robustivity
//
//  Created by Mohammad Lotfy on 2016-03-30.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

/*
 Table adapter for the table in the task updates view
 extends BaseTableAdapter via registerCellWithNib constructor
 returns 1 cell type: commentCell
 the table footer is edited to have a textfield and a button to submit new comments
 */

import UIKit
import ObjectMapper
import RealmSwift

class TaskUpdatesAdapter: BaseTableAdapter{
    
    var taskId = "1"
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        // any extra stuff to be done
    }
    
    func fetchItems() {
        if tableItems.count == 0 {
            API.get(APIRoutes.TASKS_INDEX + taskId + "/updates", callback: { (success, response) in
                if(success){
                    let responseDictionary = response as! Dictionary<String, AnyObject>
                    let commentsArray = responseDictionary["comments"]
                    let comments = Mapper<TaskCommentModel>().mapArray(commentsArray)
                    for comment in comments! {
                        self.tableItems.addObject(comment)
                        self.saveNewComment(comment)
                        self.tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, 1)), withRowAnimation: .None)
                    }
                }
            })
            tableItems = ListModel()
        }
        
    }
    
    //save new task on disk using realm
    func saveNewComment(comment: TaskCommentModel) {
        let realm = try! Realm()
        //let savedTasks =
        
        //check if is present or not
        for storedComment in    realm.objects(TaskCommentModel) {
            if storedComment.commentId == comment.taskId{
                return
            }
        }
        try! realm.write {
            realm.add(comment)
        }
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? BaseTableViewCell
        
        _cell?.label.text = tableItems.objectAtIndex(indexPath.row) as? String
    }
    
    override func configureViaMultipleIdentifiers(indexPath: NSIndexPath) -> UITableViewCell? {
        return nil
    }
    
    func offsetFrom(date:NSDate) -> String {
        
        let dayHourMinuteSecond: NSCalendarUnit = [.Day, .Hour, .Minute, .Second]
        let difference = NSCalendar.currentCalendar().components(dayHourMinuteSecond, fromDate: date, toDate: NSDate(), options: [])
        
        let seconds = "\(difference.second)s"
        let minutes = "\(difference.minute)m" + " " + seconds
        let hours = "\(difference.hour)h" + " " + minutes
        let days = "\(difference.day)d" + " " + hours
        
        if difference.day    > 0 { return days }
        if difference.hour   > 0 { return hours }
        if difference.minute > 0 { return minutes }
        if difference.second > 0 { return seconds }
        return ""
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
            as! CommentTableViewCell
        let comment = tableItems.objectAtIndex(indexPath.row) as! TaskCommentModel
        cell.name.text = comment.userName
        if (comment.content.isEmpty){
            cell.comment.text = "invalid comment from the server"
        }else{
            cell.comment.text = comment.content
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.dateFromString(comment.createdAt)
        cell.time.text = offsetFrom(date!) + " ago"
        
        let imageUrl:String = "http://hr.staging.rails.robustastudio.com/" + comment.userProfilePicture
        let url = NSURL(string: imageUrl)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: url!)
            dispatch_async(dispatch_get_main_queue(), {
                cell.avatar.image = UIImage(data: data!)
            });
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
