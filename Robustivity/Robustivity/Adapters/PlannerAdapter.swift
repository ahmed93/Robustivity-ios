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
    var numberOfItemsPerSection = 10
    
    var itemType: TaskType! {
        let index = (viewController as! PlannerViewController).segmentedControl.selectedSegmentIndex
        return index == 0 ? .Task : .Todo
    }
    
    override init(viewController: UIViewController, tableView: UITableView, registerMultipleNibsAndIdenfifers cellsNibs: NSDictionary) {
        super.init(viewController: viewController, tableView: tableView, registerMultipleNibsAndIdenfifers: cellsNibs)
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
        let config = TaskStatus.configurationOf(itemType)
        
        let inProgress = TaskModel.recent(itemType, status: config!.inProgress)
        let done = TaskModel.recent(itemType, status: config!.done)
        
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
    
    func isSeeAllCell(indexPath: NSIndexPath) -> Bool {
        return indexPath.row == numberOfItemsPerSection
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
            
            return numberOfItemsPerSection + 1
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
        // See All Table View Cell
        if isSeeAllCell(indexPath) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let itemsListViewController = PlannerItemsListViewController()
            itemsListViewController.itemType = itemType
            itemsListViewController.itemSection = indexPath.section

            viewController.navigationController?.pushViewController(itemsListViewController, animated: true)
            return
        }
        
        let taskViewController = TaskViewController(nibName: "TaskViewController", bundle: NSBundle.mainBundle())
        taskViewController.taskId = String((tableItems.objectAtIndex(indexPath.section) as! Results<TaskModel>)[indexPath.row].taskId)

        self.viewController.navigationController?.pushViewController(taskViewController, animated: true)
    }
    
    override func configureViaMultipleIdentifiers(indexPath: NSIndexPath) -> UITableViewCell? {
        if isSeeAllCell(indexPath) {
            let seeAllCell = tableView.dequeueReusableCellWithIdentifier("PlannerSeeAllCell")
            return seeAllCell
        }
        
        let plannerCell = tableView.dequeueReusableCellWithIdentifier("PlannerCell") as! PlannerTableViewCell
        let tasks = tableItems.objectAtIndex(indexPath.section) as! Results<TaskModel>
        let item = tasks[indexPath.row]
        plannerCell.itemTitle.text = item.taskName
        plannerCell.projectName.text = item.taskProjectName
        
        // Should be a singletone over the app
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        
        if indexPath.section == 0 {
            plannerCell.dueDate.text = dateFormatter.stringFromDate(item.taskStartDate!)
            plannerCell.dueDateBottomMarginLayoutConstraint.constant = 14
        } else {
            plannerCell.dueDate.text = ""
            plannerCell.dueDateBottomMarginLayoutConstraint.constant = 7
        }
        
        return plannerCell
    }
    
    
}