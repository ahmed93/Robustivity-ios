//
//  ProjectsListAdapter.swift
//  Robustivity
//
//  Created by Mariam Mohamed Fawzy on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit


class ProjectsListAdapter: BaseTableAdapter {
  
  
  override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
    super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
    tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    // any extra stuff to be done
  }
  
  func fetchItems() {
    if tableItems == nil {
      tableItems = ListModel()
    }
    tableItems.addObject(["proj_name": "Robustivity Project", "member_name" : "Hussein Mohieldin", "type": "1"])
    tableItems.addObject(["proj_name": "Robustivity Project", "member_name" : "Hussein Mohieldin", "type": "1"])
    tableItems.addObject(["proj_name": "Robustivity Project", "member_name" : "Hussein Mohieldin", "type": "2"])
    tableItems.addObject(["proj_name": "Robustivity Project", "member_name" : "Hussein Mohieldin", "type": "2"])
    tableItems.addObject(["proj_name": "Robustivity Project", "member_name" : "Hussein Mohieldin", "type": "3"])
    tableItems.addObject(["proj_name": "Robustivity Project", "member_name" : "Hussein Mohieldin", "type": "3"])
    
    tableView.reloadData()
  }
  
  
  
  
  override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
    let _cell = cell as? CustomProjectsListTableViewCell
    
    let currentCellData = tableItems.objectAtIndex(indexPath.row) as! NSDictionary
    
    _cell?.projectNameLabel.text = currentCellData.objectForKey("proj_name") as? String
    _cell?.memberLabel.text = currentCellData.objectForKey("member_name") as? String
    
    switch(currentCellData.objectForKey("type") as! String) {
    case "1": _cell?.statusUIView.backgroundColor = Theme.greenColor()
    case "2": _cell?.statusUIView.backgroundColor = Theme.orangeColor()
    case "3": _cell?.statusUIView.backgroundColor = Theme.lighterBlackColor()
    default: _cell?.statusUIView.backgroundColor = Theme.greenColor()
    }
    
    
    
    
    _cell?.marginUIView.backgroundColor = Theme.tableBackgroundColor()
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return CGFloat(57)
  }
  
  
  
  
  
  
}
