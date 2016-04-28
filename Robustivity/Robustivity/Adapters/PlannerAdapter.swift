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

                let data = self.fetchFromDatabase()
                self.refreshTable(data)
            }
        }
    }
    
    func fetchFromDatabase() -> (Results<TaskModel>, Results<TaskModel>) {
        let type:TaskType = ( selectedSegmentIndex == 0 ) ? .Task : .Todo

        let inProgress = TaskModel.recent(type, status: .InProgress)
        let done = TaskModel.recent(type, status: .Completed)

        return (inProgress, done)
    }
    
    func refreshTable(data: (Results<TaskModel>, Results<TaskModel>)){
        tableItems = ListModel()
        tableItems.addObject(data.0)
        tableItems.addObject(data.1)
        tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, 2)), withRowAnimation: .Bottom)
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
        let items = tableItems.objectAtIndex(section) as! Results<TaskModel>
        let limit = 10
        
        if items.count < limit {
            return items.count
        }

        return limit
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
        let task = tasks[indexPath.row]
        plannerCell.itemTitle.text = task.taskName
        plannerCell.projectName.text = task.taskDescription
        
        
        if indexPath.section == 0 {
            // [TODO] In Progress cell configurations
            
            plannerCell.dueDate.text = "Oct 15, 2016"
            plannerCell.dueDateBottomMarginLayoutConstraint.constant = 14
        } else {
            // [TODO] Done cell configurations
            
            plannerCell.dueDate.text = ""
            plannerCell.dueDateBottomMarginLayoutConstraint.constant = 7
        }
    }
    
    
}