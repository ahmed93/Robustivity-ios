//
//  PlannerItemsListAdapter.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 4/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import ObjectMapper
import RealmSwift

/**
 PlannerItemsListAdapter subclass of BaseTableAdapter.
 
    [TODD] Refactor it with plannerAdapter
 
 - Author:
 Ahmed Elassuty.
 - Date  :
 31/3/16.
 */
class PlannerItemsListAdapter  : BaseTableAdapter {
    var itemType:TaskType! {
        return (viewController as! PlannerItemsListViewController).itemType
    }
    
    var itemSection: Int! {
        return (viewController as! PlannerItemsListViewController).itemSection
    }
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
    }
    
    func fetchItems() {
        let data = fetchFromDatabase()
        refreshTable(data, animationOptions: .TransitionCrossDissolve)
    }
    
    func fetchFromServer() {
        API.get(APIRoutes.TASKS_INDEX) { [weak self] (success, response) -> () in
            if success {
                let dataResponse:[TaskModel]! = Mapper<TaskModel>().mapArray(response)
                TaskModel.createOrUpdate(dataResponse)
                
                if self != nil {
                    if self!.viewController.respondsToSelector("stopRefreshControl") {
                        self!.viewController.performSelector("stopRefreshControl")
                    }
                    
                    if self!.viewController.respondsToSelector("updateSearchResultsForSearchController:") {
                        let searchController = (self!.viewController as! PlannerItemsListViewController).searchController
                        self!.viewController.performSelector("updateSearchResultsForSearchController:", withObject: searchController)
                    } else {
                        // Will never be executed unless this adapter is used without a search controller
                        // for another view controller
                        let data = self!.fetchFromDatabase()
                        self!.refreshTable(data, animationOptions: .TransitionCrossDissolve)
                    }
                }
            }
        }
    }
    
    func fetchFromDatabase() -> Results<TaskModel> {
        let config = TaskStatus.configurationOf(itemType)
        let status = itemSection == 0 ? config!.inProgress : config!.done
        let items = TaskModel.recent(itemType, status: status)
        return items
    }
    
    func refreshTable(data: Results<TaskModel>, animationOptions: UIViewAnimationOptions) {
        tableItems = ListModel()
        tableItems.addObject(data)
        
        UIView.transitionWithView(tableView,
            duration: 0.35,
            options: animationOptions,
            animations: { () -> Void in
                self.tableView.reloadData()
            }, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let taskViewController = TaskViewController(nibName: "TaskViewController", bundle: NSBundle.mainBundle())
        taskViewController.taskId = String((tableItems.objectAtIndex(indexPath.section) as! Results<TaskModel>)[indexPath.row].taskId)
        
        self.viewController.navigationController?.pushViewController(taskViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableItems.objectAtIndex(0) as! Results<TaskModel>).count
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let plannerCell = cell as! PlannerTableViewCell
        plannerCell.tableView = tableView

        let tasks = tableItems.objectAtIndex(0) as! Results<TaskModel>
        let item = tasks[indexPath.row]
        plannerCell.itemTitle.text = item.taskName
        plannerCell.projectName.text = item.taskProjectName
        plannerCell.toggleTimer.text = plannerCell.toggleManager.stringFromTimeInterval(Double(item.taskDuration))
        
        plannerCell.plannerCellTask = item
        
        // Fix cell swipe actions
        if PlannerTableViewCell.pauseButtonCellConfiguration().contains(item.taskStatus) {
            plannerCell.playButtonCellSetup()
        } else {
            plannerCell.pauseButtonCellSetup()
        }
        
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
    }
}