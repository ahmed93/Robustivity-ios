//
//  FeedViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class FeedViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var adapter:FeedAdapter!
    let toggleHelper = ToggleHelper.sharedInstance
    

    
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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateToggledTimeNotification", name:"updateToggledTimeNotification", object: nil)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pauseTimerNotification", name:"pauseTimerNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resumeTimerNotification", name:"resumeTimerNotification", object: nil)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopTimerNotification", name:"stopTimerNotification", object: nil)
    }
    
    func updateToggledTimeNotification() {
        var toggleCell = adapter.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ToggleFeedTableViewCell
        toggleCell.timeLabel.text = toggleHelper.toggledTime
    }
    
    func resumeTimerNotification() {
        var toggleCell = adapter.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ToggleFeedTableViewCell
        toggleCell.taskName.text = toggleHelper.toggleTask.taskName
        toggleCell.projectName.text = toggleHelper.toggleTask.taskProjectName
    }


}
