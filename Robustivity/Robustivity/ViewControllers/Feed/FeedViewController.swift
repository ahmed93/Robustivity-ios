//
//  FeedViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import RealmSwift

class FeedViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var adapter:FeedAdapter!
    var adapter1:OptionsTableAdapter!
    var control: MoreViewController!

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("FeedViewController", owner: self, options: nil)
    }

    override func loadView() {
        super.loadView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setting View TabBartitle + navigationBarTitle
        self.title = "Feed";
        self.navigationItem.title = "Feed";
        let keys = ["checkInCell","broadCastCell","updateCell","toggleCell"]
        let values = ["CheckInFeedTableViewCell","BroadcastFeedTableViewCell","UpdateFeedTableViewCell","ToggleFeedTableViewCell"]
        let dictionary:NSDictionary = NSDictionary(objects: keys ,forKeys: values)
        adapter = FeedAdapter(viewController: self, tableView: tableView, registerMultipleNibsAndIdenfifers: dictionary)
        
        
        // Add Left navigation item
        let userStatusBarButtonItem = UIBarButtonItem(image: UIImage(named: "circle"), style: .Plain, target: self, action: nil)
        userStatusBarButtonItem.tintColor = Theme.greenColor()
        self.navigationItem.leftBarButtonItem = userStatusBarButtonItem
        print("DB LOCATION IS \(Realm.Configuration.defaultConfiguration.path!)" )
    }

}
