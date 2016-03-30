//
//  PlannerViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class PlannerViewController: BaseViewController {
    @IBOutlet weak var tableView:UITableView!
    
    var segmentedControl:UISegmentedControl!
    var adapter:PlannerAdapter!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("PlannerViewController", owner: self, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Planner";
        
        // Init segmented control
        let segmentControlItems = ["Tasks", "My ToDos"]
        initSegmentedControl(segmentControlItems)
        
        // Init Adapter
        adapter = PlannerAdapter(viewController: self, tableView: tableView, registerCellWithNib: "PlannerTableViewCell", withIdentifier: "PlannerCell")
        tableView.registerNib(UINib(nibName: "PlannerHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "PlannerHeader")
        
        // Add Right navigation item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .Plain, target: self, action: "createItemAction:")
        
        // Add Left navigation item
        let userStatusBarButtonItem = UIBarButtonItem(image: UIImage(named: "circle"), style: .Plain, target: self, action: nil)
        userStatusBarButtonItem.tintColor = Theme.greenColor()
        self.navigationItem.leftBarButtonItem = userStatusBarButtonItem
        // toggleUserStatus()
        
    }
    
    //    MARK: Segmented Control
    func initSegmentedControl(items:[AnyObject]) {
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "segmentControlAction:", forControlEvents: .ValueChanged)
        
        // Set frame size
        let frame = UIScreen.mainScreen().bounds
        segmentedControl.frame = CGRectMake(frame.minX + 10, frame.minY + 50,
            frame.width - 95, 30)
        
        self.navigationItem.titleView = segmentedControl
    }
    
    func segmentControlAction(sender: UISegmentedControl) {
        adapter.fetchItems()
    }
    
    //   MARK: Navigation Bar Actions
    
    // Right Navigation Bar Button item
    func createItemAction(sender: UIBarButtonItem) {
        if segmentedControl.selectedSegmentIndex == 0 {
            // [TODO] Create new Task
        } else {
            // [TODO] Create new ToDo
        }
    }
    
    // Lefy Navigation Bar Button item
    func toggleUserStatus(){
        let statusCircle = self.navigationItem.leftBarButtonItem
        if statusCircle!.tintColor!.isEqual(Theme.greenColor()) {
            statusCircle?.tintColor = Theme.whiteColor()
        } else {
            statusCircle?.tintColor = Theme.greenColor()
        }
    }
    
}