//
//  ProjectsListAdapter.swift
//  Robustivity
//
//  Created by Mariam Mohamed Fawzy on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit


class ProjectsListAdapter: BaseTableAdapter {
  
  var projectsListViewController: ProjectsListViewController!
  
  override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
    super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
    tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    
    projectsListViewController = viewController as! ProjectsListViewController;
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
    let projectsListCell = cell as? CustomProjectsListTableViewCell
    
    let currentCellData = tableItems.objectAtIndex(indexPath.row) as! NSDictionary
    
    projectsListCell?.projectNameLabel.text = currentCellData.objectForKey("proj_name") as? String
    projectsListCell?.memberLabel.text = currentCellData.objectForKey("member_name") as? String
    
    switch(currentCellData.objectForKey("type") as! String) {
    case "1": projectsListCell?.statusUIView.backgroundColor = Theme.greenColor()
    case "2": projectsListCell?.statusUIView.backgroundColor = Theme.orangeColor()
    case "3": projectsListCell?.statusUIView.backgroundColor = Theme.lighterBlackColor()
    default: projectsListCell?.statusUIView.backgroundColor = Theme.greenColor()
    }
    
    projectsListCell?.marginUIView.backgroundColor = Theme.tableBackgroundColor()
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return CGFloat(57)
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let projectSegmentedControlViewController = ProjectSegmentedControlViewController(nibName: "ProjectSegmentedControlViewController", bundle: nil)
   
   // projectsListViewController.presentViewController(projectSegmentedControlViewController, animated: true, completion: nil)
    let nav = projectsListViewController.navigationController
//    projectsListViewController.dismissViewControllerAnimated(false, completion: nil)
//    nav?.popToRootViewControllerAnimated(false)
//    nav?.pushViewController(projectSegmentedControlViewController, animated: true)
//    nav?.presentViewController(projectSegmentedControlViewController, animated: true, completion: nil)
//    nav?.popViewControllerAnimated(true)
//    nav?.pushViewController(projectSegmentedControlViewController, animated: true)
    // let controller = PingToUsersViewController(nibName: "PingToUsersViewController", bundle: nil)
    //navigationController?.pushViewController(controller, animated: true)
    
      nav?.pushViewController(projectSegmentedControlViewController, animated: true)//([projectSegmentedControlViewController], animated: false)
    
  
  }
  
  
  
  
}
