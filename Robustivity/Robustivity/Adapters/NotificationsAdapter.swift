//
//  NotificationsAdapter.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/28/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper


class NotificationsAdapter: BaseTableAdapter {
    
    let broadCastNotification = "doubleLineNotifCell"
    let normalNotification    = "singleLineNotifCell"
    
    let notifications:NSMutableArray = [];
    
    let headerHeight = CGFloat(40)
    
    override init(viewController: UIViewController, tableView: UITableView, registerMultipleNibsAndIdenfifers cellsNibs: NSDictionary) {
        super.init(viewController: viewController, tableView: tableView, registerMultipleNibsAndIdenfifers: cellsNibs)

        
    }
    
    

    
    
    func fetchItems() {
        
        API.get(APIRoutes.NOTIFICATIONS, callback:{ success,response in
            if(success){
                if (response.count == 0){
                    self.notifications.removeAllObjects()
                }
                else{
                    for i in 0  ..< response.count  {
                        self.notifications.addObject(Mapper<NotificationModel>().map(response[i])!)
                    }
                    API.put(APIRoutes.NOTIFICATIONS+APIRoutes.NOTIFICATIONS_MARK_READ, parameters: [:], callback: {
                        success,response in
                    })
                }
            }
            
        })
    }
    
    override func reloadItems() {
        fetchItems();
        super.reloadItems()
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //Hardcoded Stuff
        let headerTitle = "All Notifications"
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: headerHeight))
        
        let headerLabel = RBLabel(frame: CGRect(x: 10, y: 10, width: headerView.frame.width - 30, height: 20))
        headerLabel.labelType = 3020
        
        headerLabel.text = headerTitle
        
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    

    override func configureViaMultipleIdentifiers(indexPath: NSIndexPath) -> UITableViewCell? {
        fetchItems()
        let notification = notifications.objectAtIndex(indexPath.row) as! NotificationModel
        
        
        let identifer = (notification.notificationType == "messages") ? broadCastNotification : normalNotification
       
        let notificationCell = tableView.dequeueReusableCellWithIdentifier(identifer, forIndexPath: indexPath) as! NotificationsTableViewCell

        notificationCell.titleLabel.text = notification.notificationBody.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        
        let url = NSURL(string:APIRoutes.BASE_NOTIFICATIONS+notification.notificationActorProfilePictureURL)
        let data = NSData(contentsOfURL: url!)
        if data != nil {
        
            notificationCell.notificationImageView?.image = UIImage(data: data!)
        }
        else{
            notificationCell.notificationImageView?.image = UIImage(named: "Stroke 751 + Stroke 752")
        }
        notificationCell.timeLabel.text = notification.notificationCreationDate
        
        notificationCell.notificationImageView?.layer.cornerRadius = (notificationCell.imageView?.frame.width)! / 2
        notificationCell.notificationImageView?.clipsToBounds = true
        //        notificationCell.imageView?.backgroundColor = UIColor.blackColor()
        if identifer == broadCastNotification {
//            notificationCell.descriptionLabel.text = notification.objectForKey("description") as? String
            notificationCell.descriptionLabel.lineBreakMode =  .ByTruncatingTail
            notificationCell.descriptionLabel.numberOfLines = 5
            
        }
        
        return notificationCell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
