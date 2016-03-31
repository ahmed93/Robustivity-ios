//
//  UserAdapter.swift
//  Robustivity
//
//  Created by Mahmoud Eldesouky on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import UIKit

class UserAdapter: BaseTableAdapter {
    
    var tableItems2:ListModel!
    
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        // any extra stuff to be done
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
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? UserTableViewCell
        _cell?.userName.text = tableItems.objectAtIndex(indexPath.row) as? String
        _cell?.userTitle.text = tableItems2.objectAtIndex(indexPath.row) as? String
        _cell?.separatorInset.right = 20
        // _cell?.cellSeparator.backgroundColor = Theme.lightGrayColor()
        //  addSeparatorLine(_cell!, color: Theme.lightGrayColor(), margin: 50)
        //
    }
    
  }
