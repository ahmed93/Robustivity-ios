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
        if tableItems.count == 0 {
            API.get(APIRoutes.TASKS_INDEX, callback: { (success, response) in
                if(success){
                    //map the JSON object to the model and save them
                    let tasks:[TaskModel]! = Mapper<TaskModel>().mapArray(response)
                    TaskModel.createOrUpdate(tasks)
                    
                    self.tableItems.addObjectsFromArray(tasks)
                }
            })
            //tableItems = ListModel()
        }
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
        if section == 0 {
            // [TODO] replace it by the number of items IN PROGRESS returned from the server.
            //if selectedSegmentIndex == 0 {
                //return 3
            //}
            return tableItems.count
        }
        
        // Items Done Count.
        // [TODO] replace it by the number of items DONE returned from the server.
        //if selectedSegmentIndex == 0 {
            //return 3
        //}
        return tableItems.count
    }
    
    // MARK: Parent Overridden Functions
    /**
     Overrides method configure of the parent class to layout the input cell.
     - Author:
     Ahmed Elassuty.
     */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let a = TaskViewController(nibName: "TaskViewController", bundle: NSBundle.mainBundle())
        self.viewController.navigationController?.pushViewController(a, animated: true)
    }
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let plannerCell = cell as! PlannerTableViewCell
        
        let task = tableItems.objectAtIndex(indexPath.row) as! TaskModel
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