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
        if(notifications.count == 0){
            
            
            let emptyNotifications = RBLabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
            emptyNotifications.labelType = 3020
            emptyNotifications.text = "You're done for today"
            emptyNotifications.textAlignment = NSTextAlignment.Center
            emptyNotifications.translatesAutoresizingMaskIntoConstraints = false
            
            let widthConstraint = NSLayoutConstraint(item: emptyNotifications, attribute: .Width, relatedBy: .Equal,
                                                     toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 250)
            emptyNotifications.addConstraint(widthConstraint)
            
            let heightConstraint = NSLayoutConstraint(item: emptyNotifications, attribute: .Height, relatedBy: .Equal,
                                                      toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100)
            emptyNotifications.addConstraint(heightConstraint)
            viewController.view.addSubview(emptyNotifications)
            
            let xConstraint = NSLayoutConstraint(item: emptyNotifications, attribute: .CenterX, relatedBy: .Equal, toItem: self.viewController.view, attribute: .CenterX, multiplier: 1, constant: 0)
            let yConstraint = NSLayoutConstraint(item: emptyNotifications, attribute: .CenterY, relatedBy: .Equal, toItem: self.viewController.view, attribute: .CenterY, multiplier: 1, constant: 0)
            
            self.viewController.view.addConstraints([xConstraint,yConstraint])


            
           return 0
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    

    override func configureViaMultipleIdentifiers(indexPath: NSIndexPath) -> UITableViewCell? {
        
        
        
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
//        if identifer == broadCastNotification {
////            notificationCell.descriptionLabel.text = notification.objectForKey("description") as? String
//            notificationCell.descriptionLabel.lineBreakMode =  .ByTruncatingTail
//            notificationCell.descriptionLabel.numberOfLines = 5
//            
//        }
        
        return notificationCell
        
    }

}
