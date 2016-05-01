//
//  NotificationsViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class NotificationsViewController: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView?
    
    var adapter:NotificationsAdapter!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("NotificationsViewController", owner: self, options: nil)
    }
    
    override func viewDidLoad() {
        self.wantsUserCheckInStatus = true
        super.viewDidLoad()
        self.title = "Notifications";
        self.navigationItem.title = "Notifications";
        
        
        adapter = NotificationsAdapter(viewController: self, tableView: tableView!, registerMultipleNibsAndIdenfifers: ["NotificationsSingleLineTableViewCell":"singleLineNotifCell","NotificationsDoubleLineTableViewCell":"doubleLineNotifCell"])
    }
    
    
    
}
