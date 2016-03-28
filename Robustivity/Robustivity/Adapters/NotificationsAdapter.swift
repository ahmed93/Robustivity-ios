//
//  NotificationsAdapter.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/28/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class NotificationsAdapter: BaseTableAdapter {
    
    let broadCastNotification = "doubleLineNotifCell"
    let normalNotification    = "singleLineNotifCell"
    
    override init(viewController: UIViewController, tableView: UITableView, registerMultipleNibsAndIdenfifers cellsNibs: NSDictionary) {
        super.init(viewController: viewController, tableView: tableView, registerMultipleNibsAndIdenfifers: cellsNibs)
    }
    
    
    func fetchItems() {
        tableItems.addObject(["time":"Today",
            "data":[
                [
                    "type"       	:"notification",
                    "title"      	:"Don't forget to check Out!",
                    "image"      	:"Stroke 751 + Stroke 752",
                    "timestampe"  	:"01:20 pm"
                ],[
                    "type"       	:"broadcast",
                    "title"      	:"Don't forget to check Out!",
                    "image"      	:"Stroke 751 + Stroke 752",
                    "description"	:"Dear Team, Please join",
                    "timestampe"  	:"11:20 am"
                ]]
            ])
        tableItems.addObject(["time":"Yesterday",
            "data":[
                [
                    "type"       	:"notification",
                    "title"      	:"Don't forget to check Out!",
                    "image"      	:"Stroke 751 + Stroke 752",
                    "timestampe"  	:"09:20 pm"
                ],[
                    "type"       	:"broadcast",
                    "title"      	:"Don't forget to check Out!",
                    "image"      	:"Stroke 751 + Stroke 752",
                    "description"	:"Dear Team, Please join",
                    "timestampe"  	:"05:20 pm"
                ],[
                    "type"       	:"notification",
                    "title"      	:"Don't forget to check Out!",
                    "image"      	:"Stroke 751 + Stroke 752",
                    "timestampe"  	:"04:20 pm"
                ],[
                    "type"       	:"broadcast",
                    "title"      	:"Don't forget to check Out!",
                    "image"      	:"Stroke 751 + Stroke 752",
                    "description"	:"Dear Team, Please join",
                    "timestampe"  	:"03:20 pm"
                ],[
                    "type"       	:"notification",
                    "title"      	:"Don't forget toDear Team, Please joinDear Team, Please joinDear Team, Please joinDear Team, Please joinDear Team, Please joinDear Team, Please join check Out!",
                    "image"      	:"Stroke 751 + Stroke 752",
                    "timestampe"  	:"01:20 pm"
                ],[
                    "type"       	:"broadcast",
                    "title"      	:"Don't forget to check Out!",
                    "image"      	:"Stroke 751 + Stroke 752", 
                    "description"	:"Dear Team, Please joinDear Team, Please joinDear Team, Please joinDear Team, Please joinDear Team, Please joinDear Team, Please joinDear Team, Please joinDear Team, PleasPlease jPlease jPlease jPlease jPlease jPlease jPlease jPlease jPlease jPlease jPlease jPlease jPlease jPlease jPleaselease jPlease je joinDear Team, Please joinDear Team, Please joinDear Team, Please join",
                    "timestampe"  	:"01:20 am"
                ]]
            ])
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerTitle = (tableItems.objectAtIndex(section) as! NSDictionary).objectForKey("time") as! String
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: 30))
        
        let headerLabel = RBLabel(frame: CGRect(x: 10, y: 5, width: headerView.frame.width - 30, height: 20))
        headerLabel.labelType = 3020
        
        headerLabel.text = headerTitle
        
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableItems.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((tableItems.objectAtIndex(section) as! NSDictionary).objectForKey("data")?.count)!
    }
    

    override func configureViaMultipleIdentifiers(indexPath: NSIndexPath) -> UITableViewCell? {
        let notification = ((tableItems.objectAtIndex(indexPath.section) as! NSDictionary).objectForKey("data") as! NSArray).objectAtIndex(indexPath.row) as! NSDictionary
        
        let identifer = (notification.objectForKey("type")?.isEqualToString("broadcast"))! ? broadCastNotification : normalNotification
        
        let notificationCell = tableView.dequeueReusableCellWithIdentifier(identifer, forIndexPath: indexPath) as! NotificationsTableViewCell
        
        notificationCell.titleLabel.text = notification.objectForKey("title") as? String
        notificationCell.imageView?.image = UIImage(named: (notification.objectForKey("image") as! String) )
        notificationCell.timeLabel.text = notification.objectForKey("timestampe") as? String
        
        if identifer == broadCastNotification {
            notificationCell.descriptionLabel.text = notification.objectForKey("description") as? String
            notificationCell.descriptionLabel.lineBreakMode =  .ByTruncatingTail
            notificationCell.descriptionLabel.numberOfLines = 5

        }
        
        
        return notificationCell
        
    }
    

}
