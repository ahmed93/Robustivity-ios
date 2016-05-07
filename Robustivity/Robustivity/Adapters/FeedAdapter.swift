//
//  FeedAdapter.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class FeedAdapter: BaseTableAdapter {
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        // any extra stuff to be done
    }
    
    override init(viewController: UIViewController, tableView: UITableView, registerMultipleNibsAndIdenfifers cellsNibs: NSDictionary) {
        //  FeedAdapter.feed = FeedAdapter.fillFeedWithDummyData()
        super.init(viewController: viewController, tableView: tableView, registerMultipleNibsAndIdenfifers: cellsNibs)
    }
    
    
    func fetchItems() {
        
        if tableItems.count == 0 {
            tableItems = ListModel()
            
            API.get( APIRoutes.FEED_INDEX, callback: { (success, response) in
                
                if(success){
                    let feeds = Mapper<FeedModel>().mapArray(response)
                    
                    for feed in feeds! {
                        self.saveNewFeed(feed)
                        self.tableItems.addObject(feed)
                    }
                    self.tableItems.reverse()
                    self.tableView.reloadData()
                }

            })
            
        }
    }
    
    // Assuty
//    func toggleTimer(timer: NSTimer, didUpdateTimerWithValue: String) {
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ToggleFeedTableViewCell
//        cell.timeLabel.text = didUpdateTimerWithValue
//    }
//    
//    func toggleTimer(timer: NSTimer, didStartTimer: String) {
//        print("Did Start Timer")
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ToggleFeedTableViewCell
//        let toggleHelper = ToggleHelper.sharedInstance
//        cell.playButtonCellSetup()
//        cell.toggleCellTask = toggleHelper.toggleTask
//        cell.taskName.text = toggleHelper.toggleTask.taskName
//        cell.projectName.text = toggleHelper.toggleTask.taskProjectName
//        cell.timeLabel.text = toggleHelper.toggledTime
//        cell.playPauseButton.enabled = true
//        cell.timeLabel.text = didStartTimer
//    }
//    
//    func toggleTimer(toggleManager: ToggleHelper, task: TaskModel, value: String) {
//        print("Did Start Timer")
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ToggleFeedTableViewCell
//        cell.playButtonCellSetup()
//        cell.toggleCellTask = toggleManager.toggleTask
//        cell.taskName.text = toggleManager.toggleTask.taskName
//        cell.projectName.text = toggleManager.toggleTask.taskProjectName
//        cell.timeLabel.text = toggleManager.toggledTime
//        cell.playPauseButton.enabled = true
//        cell.timeLabel.text = value
//    }
    
//    func toggleTimer(timer: NSTimer, didPauseTimer: Bool) {
//        if(didPauseTimer) {
//            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ToggleFeedTableViewCell
//            cell.pauseButtonCellSetup()
//
//        }
//    }
//    
//    func toggleTimer(toggleManager: ToggleHelper, didChangeTask task: TaskModel, withInitValue: String) {
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ToggleFeedTableViewCell
//        let toggleHelper = ToggleHelper.sharedInstance
//        cell.playButtonCellSetup()
//        cell.toggleCellTask = toggleHelper.toggleTask
//        cell.taskName.text = toggleHelper.toggleTask.taskName
//        cell.projectName.text = toggleHelper.toggleTask.taskProjectName
//        cell.timeLabel.text = toggleHelper.toggledTime
//        cell.playPauseButton.enabled = true
//        cell.timeLabel.text = withInitValue
//    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? BaseTableViewCell
        
        _cell?.label.text = tableItems.objectAtIndex(indexPath.row) as? String
    }
    
    /*
     Made by Khaled Elhossiny
     this function checks the feed data and returns different type of cells
     based on the index of the feed data, it either returns cells of type :
     BroadCastFeedTableViewCell
     CheckInFeedTableViewCell
     NotificationTableViewCell
     or a ToggleFeedCell in the header
     */
        
    override func configureViaMultipleIdentifiers(indexPath: NSIndexPath) -> UITableViewCell? {
        if(indexPath.section == 0){
            var toggleCell = tableView.dequeueReusableCellWithIdentifier("toggleCell") as! ToggleFeedTableViewCell
            toggleCell.playPauseButton.enabled = false
            return toggleCell
//            return tableView.dequeueReusableCellWithIdentifier("toggleCell") as! ToggleFeedTableViewCell
        }
        else{
            let feed = tableItems.objectAtIndex(indexPath.row)as! FeedModel
            let cell:UITableViewCell?
            
            switch feed.type {
            case "broadcast":
                cell = self.broadCastFeedCell(tableView, feed: feed )
            case "check":
                cell = self.checkInFeedCell(tableView, feed: feed )
            case "new_task":
                cell = self.notificationFeedCell(tableView, feed: feed)
            default:
                cell = nil
            }
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return tableItems.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    /*
     Made by Khaled Elhossiny
     this function return dummy data to be displayed in feed
     note that the image of the imageview is set from a url
     */
    
    /* static func fillFeedWithDummyData() -> [FeedModel]{
     let user = UserModel(avatar: NSURL(string: "")!, name: "Islam")
     let bf1 = BroadcastFeedModel(user: user, tiemStamp: "Yesterday", content: "Dear Team, PLease join me in welcoming @AhmedHamouda who joined as a PHP Developer in the Development division.\nWelcome Hamouda to robusta's Superb team :)")
     let bf2 = BroadcastFeedModel(user: user, tiemStamp: "Yesterday", content: "Dear Team, PLease join me in welcoming @AhmedHamouda who joined as a PHP Developer in the Development division.\nWelcome Hamouda to robusta's Superb team :)")
     let bf3 = BroadcastFeedModel(user: user, tiemStamp: "Yesterday", content: "Dear Team, PLease join me in welcoming @AhmedHamouda who joined as a PHP Developer in the Development division.\nWelcome Hamouda to robusta's Superb team :)")
     let nf = UpdateFeedModel(content: "Robustivity Project has 4 tasks done.",timeStamp: "Oct 12,2015")
     let cif = CheckInFeedModel(user: user, tiemStamp: "now")
     return [bf1,nf,bf2,cif,bf3]
     }*/
    
    /*
     Made by Khaled Elhossiny
     this function takes a Broadcast Feed model as parameter
     and returns a cell for this feed by setting its labels
     and imageview according to the feed object
     */
    
    func broadCastFeedCell(tableView: UITableView, feed:FeedModel) -> BroadcastFeedTableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("broadCastCell") as! BroadcastFeedTableViewCell
        cell.broadcastTextLabel.text = feed.content
        cell.broadcastTitleLabel.text = feed.userName + " sent a broadcast"
        cell.timestampsLabel.text? = self.getTimeDifference(feed.timeStamp)
        let avatarURL:NSURL? = NSURL(string: APIRoutes.URL + feed.profilePicture)
        let avatarImage:UIImage? = UIImage(data: NSData(contentsOfURL: avatarURL!)!)
        cell.avatarImageView.image = avatarImage!
        return cell
        
    }
    
    /*
     Made by Khaled Elhossiny
     this function is responsible for generating a seperator between
     different cells of the tableview
     */
    
    /* func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
     
     if indexPath.section > 0{
     cell.contentView.backgroundColor = UIColor.clearColor()
     
     let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 5))
     
     whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
     whiteRoundedView.layer.masksToBounds = false
     whiteRoundedView.layer.cornerRadius = 2.0
     whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
     whiteRoundedView.layer.shadowOpacity = 0.2
     
     cell.contentView.addSubview(whiteRoundedView)
     cell.contentView.sendSubviewToBack(whiteRoundedView)
     }
     }
     */
    
    /*
     Made by Khaled Elhossiny
     this function takes a CheckIn Feed model as parameter
     and returns a cell for this feed by setting its labels
     and imageview according to the feed object
     */
    
    func checkInFeedCell(tableView: UITableView, feed:FeedModel) -> CheckInFeedTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("checkInCell") as! CheckInFeedTableViewCell
        cell.checkInTitleLabel.text = feed.userName + " has" + self.updateCheckInFeedContent(feed.content)
        cell.timeStampsLabel.text = self.getTimeDifference(feed.timeStamp)
        let avatarURL:NSURL? = NSURL(string: APIRoutes.URL + feed.profilePicture)
        let avatarImage:UIImage? = UIImage(data: NSData(contentsOfURL: avatarURL!)!)
        cell.avatarImageView.image = avatarImage!
        return cell
        
    }
    /*
     Made by Khaled Elhossiny
     this function takes a Notification Feed model as parameter
     and returns a cell for this feed by setting its labels
     according to the feed object
     */
    
    func notificationFeedCell(tableView: UITableView, feed:FeedModel) -> UpdateFeedTableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("updateCell") as! UpdateFeedTableViewCell
        cell.updateLabel.text = feed.userName + " has added a new task"
        cell.taskLabel.text = feed.content
        cell.timeStampsLabel.text = self.getTimeDifference(feed.timeStamp)
        let avatarURL:NSURL? = NSURL(string: APIRoutes.URL + feed.profilePicture)
        let avatarImage:UIImage? = UIImage(data: NSData(contentsOfURL: avatarURL!)!)
        cell.avatarImageView.image = avatarImage!
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.5
        }
        else{
            return 0.0
        }
    }
    
    
    /*
     Made by Khaled Elhossiny
     the table view has 2 sections, one for toggle view
     and the other for other feed cells
     */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func updateCheckInFeedContent(content :String)-> String{
        
        let split = content.componentsSeparatedByString(" ")
        return String(" " + split[0].lowercaseString + " " + split[1])
        
    }
    
    
    /* This function returns the time intervel between the Feed's
     timestamp and current time of the app *
     */
    func getTimeInterval(time: String) -> NSTimeInterval{
        
        let formatter = NSDateFormatter();
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
        formatter.timeZone = NSTimeZone(name: "EET");
        let currentTime =  formatter.dateFromString(formatter.stringFromDate(NSDate()))
        let givenDate = formatter.dateFromString(time)
        let diff = currentTime!.timeIntervalSinceDate(givenDate!)
        return diff
        
        
    }
    
    /* This function returns a string for time interval eg. 3 hours ago  *
     */
    func getTimeDifference(time: String) -> String{
        var timeOutput:String = ""
        let diff = self.getTimeInterval(time)
        let hours = NSInteger(diff/3600);
        let days = NSInteger(hours/24);
        
        let mins = NSInteger((diff % 3600) / 60);
        if(diff == 0){
            timeOutput = "Just now"
        }
        else if(hours>=24){
            timeOutput = "\(days) days ago"
        }
        else if(hours == 0){
            timeOutput = "\(mins) minutes ago"
        }
        else{
            timeOutput = "\(hours) hours ago"
        }
        return timeOutput
    }
    
    
    func saveNewFeed(feed: FeedModel) {
        let realm = try! Realm()
        let savedfeeds = realm.objects(FeedModel)
        
        for checkfeed in savedfeeds {
            if checkfeed.feedId == feed.feedId {
                return
            }
        }
        
        try! realm.write {
            realm.add(feed)
        }
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



extension FeedAdapter : ToggleManagerDelegate {
    func toggleManager(toggleManager: ToggleManager, hasTask task: TaskModel?, toggledTime: String?) {
        
        let toggleCellIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        if task != nil && isValidIndexPath(toggleCellIndexPath) {
            let toggleCell = tableView.cellForRowAtIndexPath(toggleCellIndexPath) as! ToggleFeedTableViewCell
            toggleCell.toggleCellTask = task!
            toggleCell.taskName.text = task!.taskName
            toggleCell.projectName.text = task!.taskProjectName
        }

        
    }
    
    func toggleManager(toggleManager: ToggleManager, didChangeToggledTask task: TaskModel, toggledTime: String) {
        
    }
    
    func toggleManager(toggleManager: ToggleManager, didUpdateTimer value: String) {
        let toggleCellIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        if isValidIndexPath(toggleCellIndexPath) {
            let toggleCell = tableView.cellForRowAtIndexPath(toggleCellIndexPath) as! ToggleFeedTableViewCell
            toggleCell.timeLabel.text = value
        }
       

    }
}