//
//  NotificationsViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class NotificationsViewController: BaseViewController {

    @IBOutlet weak var tableView:UITableView?
    let notifications:NSMutableArray = [];
    
    
    var adapter:NotificationsAdapter!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("NotificationsViewController", owner: self, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notifications";
        self.navigationItem.title = "Notifications";
        
        API.get(APIRoutes.NOTIFICATIONS, callback:{ success,response in
            if(success){
                
                for i in 0  ..< response.count  {
                self.notifications.addObject(Mapper<NotificationModel>().map(response[i])!)
                }
            }
            print((self.notifications[2]as! NotificationModel).notificationActorName)
            
        })
        
        
        adapter = NotificationsAdapter(viewController: self, tableView: tableView!, registerMultipleNibsAndIdenfifers: ["NotificationsSingleLineTableViewCell":"singleLineNotifCell","NotificationsDoubleLineTableViewCell":"doubleLineNotifCell"])
    }
    
    

}
