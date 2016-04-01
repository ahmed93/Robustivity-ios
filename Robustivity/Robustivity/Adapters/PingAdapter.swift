//
//  PingAdapter.swift
//  Robustivity
//
//  Created by Almgohar on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import UIKit


class PingAdapter: BaseTableAdapter {
    
    var tableItems2:ListModel!
    
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
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
    
    var selectedCell:UITableViewCell?{
        willSet{
            selectedCell?.accessoryType = .None
            newValue?.accessoryType = .Checkmark
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCell = self.tableView.cellForRowAtIndexPath(indexPath)
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? UserTableViewCell
        _cell?.userName.text = tableItems.objectAtIndex(indexPath.row) as? String
        _cell?.userTitle.text = tableItems2.objectAtIndex(indexPath.row) as? String
    }
    
}
