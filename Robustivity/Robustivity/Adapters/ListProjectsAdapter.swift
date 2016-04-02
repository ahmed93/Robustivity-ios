//
//  ListProjectsAdapter.swift
//  Robustivity
//
//  Created by Mahmoud Eldesouky on 4/2/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//
//
//  UserAdapter.swift
//  Robustivity
//
//  Created by Mahmoud Eldesouky on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import UIKit

// UserAdapter used to display the User TableViews, using the UserTableViewCell.
// Remove the tableView Separator from your controller using: self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None

class ListProjectsAdapter: BaseTableAdapter {
    
    var tableItems2:ListModel!
    var ChooseProjectController:ChooseProjectViewController!
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        ChooseProjectController = viewController as? ChooseProjectViewController

    }
    
    
    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
        tableItems.addObject("Islam Abdelrouf")
        tableItems.addObject("Ahmed Magdy")
        tableItems.addObject("Mahmoud Eldesouky")
        tableItems.addObject("Ahmed Mohamed ElAssuty")
        tableItems.addObject("Mahmoud Eldesouky")
        tableItems.addObject("Mohamed Lotfy")
        tableItems.addObject("Islam Abdelrouf")
        tableItems.addObject("Ahmed Magdy")
        tableItems.addObject("Mahmoud Eldesouky")
        tableItems.addObject("Ahmed Mohamed ElAssuty")
        tableItems.addObject("Mahmoud Eldesouky")
        tableItems.addObject("Mohamed Lotfy")
        
        tableView.reloadData()
        if tableItems2 == nil {
            tableItems2 = ListModel()
        }
        tableItems2.addObject("Project Manager")
        tableItems2.addObject("UI Designer")
        tableItems2.addObject("iOS Developer")
        tableItems2.addObject("iOS Developer")
        tableItems2.addObject("Project Manager")
        tableItems2.addObject("UI Designer")
        tableItems2.addObject("iOS Developer")
        tableItems2.addObject("iOS Developer")
        tableItems2.addObject("Project Manager")
        tableItems2.addObject("UI Designer")
        tableItems2.addObject("iOS Developer")
        tableItems2.addObject("iOS Developer")
        
        tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if self.ChooseProjectController.respondsToSelector(Selector("getTodo"))
        {
            if self.ChooseProjectController.getTodo()
            {
                let controller = CreateTaskViewController()
                viewController.navigationController?.pushViewController(controller, animated: true)
            }
            else{
                let controller = ChooseAssigneeViewController(nibName: "ChooseAssigneeViewController", bundle: nil)
                viewController.navigationController?.pushViewController(controller, animated: true)
            }
        }

    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? UserTableViewCell
        _cell?.userName.text = tableItems.objectAtIndex(indexPath.row) as? String
        _cell?.userTitle.text = tableItems2.objectAtIndex(indexPath.row) as? String
    }
    
}
