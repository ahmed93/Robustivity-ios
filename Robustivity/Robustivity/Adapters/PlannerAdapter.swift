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
        // Setting the segment index must be done before initializing the adapter
        // as long as the bug of loading all tabs upon launch exists
//        selectedSegmentIndex = (viewController as! PlannerViewController).segmentedControl.selectedSegmentIndex

        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
    }
    
    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Items Progress Count
        if selectedSegmentIndex == 0 {
            // [TODO] replace it by the number of items in progress returned from the server
            return 5
        }

        // Items Done Count
        // [TODO] replace it by the number of items done returned from the server
        return 7
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let plannerCell = cell as? PlannerTableViewCell
        
        if indexPath.section == 0 {
            plannerCell?.dueDate.text = "Oct 15, 2015"
            plannerCell?.bottomCellLayoutConstraint.constant = 14
        } else {
            plannerCell?.dueDate.text = ""
            plannerCell?.bottomCellLayoutConstraint.constant = 0
        }
    }


}
