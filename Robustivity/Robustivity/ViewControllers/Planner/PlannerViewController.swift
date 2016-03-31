//
//  PlannerViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//


import UIKit

/**

 - Author: 
    Ahmed Elassuty.
 - Date  : 
    31/3/16.

 */
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
        loadSegmentedControl(segmentControlItems)
        
        // Init Adapter
        adapter = PlannerAdapter(viewController: self, tableView: tableView, registerCellWithNib: "PlannerTableViewCell", withIdentifier: "PlannerCell")
        tableView.registerNib(UINib(nibName: "PlannerHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "PlannerHeader")
        
        // Add Right navigation item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .Plain, target: self, action: "createItemAction:")
        
        // Add Left navigation item
        let userStatusBarButtonItem = UIBarButtonItem(image: UIImage(named: "circle"), style: .Plain, target: self, action: nil)
        userStatusBarButtonItem.tintColor = Theme.greenColor()
        self.navigationItem.leftBarButtonItem = userStatusBarButtonItem
    }
    
    //    MARK: Segmented Control
    
    /**
        Loads segmented control to the Planner view controller navigation bar.

        - Author: 
            Ahmed Elassuty.
        - Parameter items:
            Array of AnyObject items that should be shown in the segment control.
    */
    func loadSegmentedControl(items:[AnyObject]) {
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "segmentControlAction:", forControlEvents: .ValueChanged)
        
        // Set frame size
        let frame = UIScreen.mainScreen().bounds
        segmentedControl.frame = CGRectMake(frame.minX + 10, frame.minY + 50,
            frame.width - 95, 30)
        
        self.navigationItem.titleView = segmentedControl
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
        adapter.fetchItems()
    }
    
    // MARK: Navigation Bar Items Actions
    
    /**
        Creates new Task or ToDo navigation bar button item action. This method renders the appropriate view controller based on the selected segment.

        - Author: 
            Ahmed Elassuty
        - Parameter sender:
            The right clicked bar button.
        - TODO:
            Add the right view controllers upon integration.
    */
    func createItemAction(sender: UIBarButtonItem) {
        assertionFailure("Add the right view controllers upon integration.")
        // let viewController:UIViewController;
        
        if segmentedControl.selectedSegmentIndex == 0 {
            // [TODO] Create new Task
            // Replace viewController
            // projectAssignmentViewController = ProjectAssignmentViewController()
        } else {
            // [TODO] Create new ToDo
            // Replace viewController
            // projectAssignmentViewController = CREATE TODO View Controller
        }
        
        // self.navigationController?.pushViewController(projectAssignmentViewController, animated: true)
    }

    /**
        Toggle user status left bar item circle color.

        - Author: Ahmed Elassuty
    
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