//
//  PlannerAdapter.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 3/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class PlannerAdapter: BaseTableAdapter {
    var selectedSegmentIndex: Int! {
        return (viewController as! PlannerViewController).segmentedControl.selectedSegmentIndex
    }
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)

        tableView.sectionHeaderHeight = 44
    }

    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
        tableView.reloadData()
    }
    
    // MARK: Table view delegate and datasource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabelType = [3040, 3040]
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
        // Items Progress Count
        if section == 0 {
            // [TODO] replace it by the number of items in progress returned from the server
            return 5
        }

        // Items Done Count
        // [TODO] replace it by the number of items done returned from the server
        return 5
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected")
    }

    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let plannerCell = cell as? PlannerTableViewCell
        
        if indexPath.section == 0 {
            plannerCell?.dueDate.text = "Oct 15, 2015"
            plannerCell?.bottomCellLayoutConstraint.constant = 14
        } else {
            plannerCell?.dueDate.text = ""
            plannerCell?.bottomCellLayoutConstraint.constant = 7
        }
    }


}
