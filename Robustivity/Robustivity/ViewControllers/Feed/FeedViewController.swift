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
    let toggleHelper = ToggleHelper.sharedInstance
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("FeedViewController", owner: self, options: nil)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    
    override func viewDidLoad() {
        self.wantsUserCheckInStatus = true
        
        super.viewDidLoad()
        print("DB LOCATION IS \(Realm.Configuration.defaultConfiguration.path!)" )
        // setting View TabBartitle + navigationBarTitle
        self.title = "Feed";
        self.navigationItem.title = "Feed";
        let keys = ["checkInCell","broadCastCell","updateCell","toggleCell"]
        let values = ["CheckInFeedTableViewCell","BroadcastFeedTableViewCell","UpdateFeedTableViewCell","ToggleFeedTableViewCell"]
        let dictionary:NSDictionary = NSDictionary(objects: keys ,forKeys: values)
        adapter = FeedAdapter(viewController: self, tableView: tableView, registerMultipleNibsAndIdenfifers: dictionary)
        self.toggleHelper.feedViewDelegate = self.adapter

        updateStickyToggleCell ()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.toggleHelper.timerDelegate = self.adapter // Assuty
        
        updateStickyToggleCell ()
        
    }
    
    func updateStickyToggleCell () {
        if (toggleHelper.toggleTask.taskId == 0) {
            return
            
        }
        let toggleCell = adapter.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ToggleFeedTableViewCell
        toggleCell.taskName.text = toggleHelper.toggleTask.taskName
        toggleCell.projectName.text = toggleHelper.toggleTask.taskProjectName
        toggleCell.toggleCellTask = toggleHelper.toggleTask
        toggleCell.timeLabel.text = toggleHelper.toggledTime
        toggleCell.playPauseButton.enabled = true
        // Fix cell swipe actions
        if ToggleFeedTableViewCell.pauseButtonCellConfiguration().contains(toggleHelper.toggleTask.taskStatus) {
            toggleCell.playButtonCellSetup()
        } else {
            toggleCell.pauseButtonCellSetup()
        }
    }
    
    
}
