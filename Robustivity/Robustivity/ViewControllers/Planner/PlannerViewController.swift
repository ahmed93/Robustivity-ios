//
//  PlannerViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import RealmSwift
/**
    PlannerViewController subclass of BaseViewController
 
    - Author:
        Ahmed Elassuty.
    - Date  :
        3/31/16.
 */

// MISSING Views
    // EMPTY STATE OF SECTION
class PlannerViewController: BaseViewController {
    @IBOutlet weak var tableView:UITableView!
    
    // Constants
    let segmentControlItems = ["Tasks", "My ToDos"]

    // Variables
    var segmentedControl:UISegmentedControl!
    var refreshControl:UIRefreshControl!

    var adapter:PlannerAdapter!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("PlannerViewController", owner: self, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Planner";
        
        // Add segmented control
        addSegmentedControl(segmentControlItems)
        
        addRefreshControl()
        
        // Init Adapter
        adapter = PlannerAdapter(viewController: self, tableView: tableView, registerCellWithNib: "PlannerTableViewCell", withIdentifier: "PlannerCell")
        tableView.registerNib(UINib(nibName: "PlannerHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "PlannerHeader")
        
        // Add Right navigation item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .Plain, target: self, action: "createItemAction:")
        
        // Add Left navigation item
        let userStatusBarButtonItem = UIBarButtonItem(image: UIImage(named: "circle"), style: .Plain, target: self, action: nil)
        userStatusBarButtonItem.tintColor = Theme.greenColor()
        self.navigationItem.leftBarButtonItem = userStatusBarButtonItem
        
        print("DB LOCATION IS \(Realm.Configuration.defaultConfiguration.path!)" )
        
        
        
    }
    
    //    MARK: Segmented Control
    
    /**
        Loads segmented control to the Planner view controller navigation bar.

        - Author: 
            Ahmed Elassuty.
        - Parameter items:
            Array of AnyObject items that should be shown in the segment control.
    */
    func addSegmentedControl(items:[AnyObject]) {
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "segmentControlAction:", forControlEvents: .ValueChanged)
        
        // Set frame size
        let frame = UIScreen.mainScreen().bounds
        segmentedControl.frame = CGRectMake(frame.minX + 10, frame.minY + 50,
            frame.width - 95, 30)
        
        self.navigationItem.titleView = segmentedControl
    }
    
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "startRefreshControl", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    // MARK: Segment Control Action
    
    /**
        Segment control action. This method reloades the main tableView cells data.
    
        - Author:
            Ahmed Elassuty.
        - Note:
            The implementation of this method may be changed in the development phase.
    */
    func segmentControlAction(sender: UISegmentedControl) {
        let data = adapter.fetchFromDatabase()
        adapter.refreshTable(data, animationOptions: .TransitionFlipFromLeft)
    }
    
    // MARK: Refresh Control Action
    func startRefreshControl() {
        adapter.fetchFromServer()
    }
    
    func stopRefreshControl() {
        refreshControl.endRefreshing()
    }
    
    // MARK: Navigation Bar Items Actions
    
    /**
        Creates new Task or ToDo navigation bar button item action. This method renders the appropriate view controller based on the selected segment.

        - Author: 
            Ahmed Elassuty.
        - Parameter sender:
            The right clicked bar button.
    */
    func createItemAction(sender: UIBarButtonItem) {
        let controller = ChooseProjectViewController(nibName:"ChooseProjectViewController",bundle: nil)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            controller.isTodo(false)
        } else {
            controller.isTodo(true)
        }
        
        let navController = UINavigationController(rootViewController: controller)
        self.navigationController?.presentViewController(navController, animated: true, completion: nil)
    }

    /**
        Toggle user status left bar item circle color.

        - Author: 
            Ahmed Elassuty.
        - TODO:
            - Move this method to baseViewController.
            - Disable user interaction.
    */
    func toggleUserStatus() {
        let statusCircle = self.navigationItem.leftBarButtonItem
        if statusCircle!.tintColor!.isEqual(Theme.greenColor()) {
            statusCircle?.tintColor = Theme.whiteColor()
        } else {
            statusCircle?.tintColor = Theme.greenColor()
        }
    }
    
}