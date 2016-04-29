//
//  PlannerAdapter.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 3/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
/**
 PlannerAdapter subclass of BaseTableAdapter.
 
 - Author:
 Ahmed Elassuty.
 - Date  :
 31/3/16.
 */
class PlannerAdapter: BaseTableAdapter {
    let numberOfItemsPerSection = 10
    
    var selectedSegmentIndex: Int! {
        return (viewController as! PlannerViewController).segmentedControl.selectedSegmentIndex
    }
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
    }
    
    // MARK: Base Adapter Delegate methods
    func fetchItems() {
        fetchFromServer()
    }
    
    func fetchFromServer() {
        API.get(APIRoutes.TASKS_INDEX) { (success, response) -> () in
            if success {
                let dataResponse:[TaskModel]! = Mapper<TaskModel>().mapArray(response)
                TaskModel.createOrUpdate(dataResponse)
                
                if self.viewController.respondsToSelector("stopRefreshControl") {
                    self.viewController.performSelector("stopRefreshControl")
                }
                
                let data = self.fetchFromDatabase()
                self.refreshTable(data, animationOptions: .TransitionCrossDissolve)
            }
        }
    }
    
    func fetchFromDatabase() -> (Results<TaskModel>, Results<TaskModel>) {
        let type:TaskType! = selectedSegmentIndex == 0 ? .Task : .Todo
        let config = TaskStatus.configurationOf(type)
        
        let inProgress = TaskModel.recent(type, status: config!.inProgress)
        let done = TaskModel.recent(type, status: config!.done)
        
        return (inProgress, done)
    }
    
    func refreshTable(data: (Results<TaskModel>, Results<TaskModel>), animationOptions: UIViewAnimationOptions) {
        tableItems = ListModel()
        tableItems.addObject(data.0)
        tableItems.addObject(data.1)
        UIView.transitionWithView(tableView,
            duration: 0.35,
            options: animationOptions,
            animations: { () -> Void in
                self.tableView.reloadData()
            }, completion: nil)
    }
    
    // MARK: Table view delegate and datasource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabelType = [3040, 3070]
        let headerLabelText = ["In Progress", "Done"]
        
        let headerCell = tableView.dequeueReusableCellWithIdentifier("PlannerHeader") as! PlannerHeaderTableViewCell
        headerCell.headerLabel.labelType = headerLabelType[section]
        headerCell.headerLabel.text = headerLabelText[section]
        return headerCell.contentView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableItems.count > 0 {
            let items = tableItems.objectAtIndex(section) as! Results<TaskModel>
            
            if items.count < numberOfItemsPerSection {
                return items.count
            }
            
            return numberOfItemsPerSection
        }
        
        return 0
    }
    
    // MARK: Parent Overridden Functions
    /**
    Overrides method configure of the parent class to layout the input cell.
    - Author:
    Ahmed Elassuty.
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let taskViewController = TaskViewController(nibName: "TaskViewController", bundle: NSBundle.mainBundle())
        self.viewController.navigationController?.pushViewController(taskViewController, animated: true)
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let plannerCell = cell as! PlannerTableViewCell
        
        let tasks = tableItems.objectAtIndex(indexPath.section) as! Results<TaskModel>
        let item = tasks[indexPath.row]
        plannerCell.itemTitle.text = item.taskName
        plannerCell.projectName.text = item.taskDescription
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        
        if indexPath.section == 0 {
            // [TODO] In Progress cell configurations
            
            plannerCell.dueDate.text = dateFormatter.stringFromDate(item.taskStartDate!)
            plannerCell.dueDateBottomMarginLayoutConstraint.constant = 14
        } else {
            // [TODO] Done cell configurations
            
            plannerCell.dueDate.text = ""
            plannerCell.dueDateBottomMarginLayoutConstraint.constant = 7
        }
    }
    
    
}