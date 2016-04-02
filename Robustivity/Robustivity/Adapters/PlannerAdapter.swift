//
//  PlannerAdapter.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 3/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

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
        if tableItems == nil {
            tableItems = ListModel()
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
            if selectedSegmentIndex == 0 {
                return 7
            }
            return 5
        }

        // Items Done Count.
        // [TODO] replace it by the number of items DONE returned from the server.
        if selectedSegmentIndex == 0 {
            return 2
        }
        return 4
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let taskViewController = TaskViewController()
        self.viewController.navigationController?.pushViewController(taskViewController, animated: true)
    }

    // MARK: Parent Overridden Functions
    /**
        Overrides method configure of the parent class to layout the input cell.
    
        - Author:
            Ahmed Elassuty.
        - Parameters:
            - cell: 
                Table view cell that the table view will render.
            - indexPath:
                The index path of the current cell.
    */
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let plannerCell = cell as! PlannerTableViewCell

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