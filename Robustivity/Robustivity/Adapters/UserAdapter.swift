//
//  UserAdapter.swift
//  Robustivity
//
//  Created by Mahmoud Eldesouky on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

// UserAdapter used to display the User TableViews, using the UserTableViewCell.
// Remove the tableView Separator from your controller using: self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None 

class UserAdapter: BaseTableAdapter {
    var project_id:Int!
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        self.project_id = (viewController as! ChooseAssigneeViewController).project_id
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
    }
    
    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
        API.get(APIRoutes.PROJECTS_INDEX + String(project_id), callback: { (success, response) in
            if(success){
                let users = Mapper<User>().mapArray(response.objectForKey("members"))
                for user in users! {
                    self.tableItems.addObject(user)
                    user.save()
                }
                self.tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, 1)), withRowAnimation: .Bottom)
                
            }
        })
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user =  tableItems.objectAtIndex(indexPath.row) as! User
        let createTaskViewController = CreateTaskViewController()
        self.viewController.navigationController?.pushViewController(createTaskViewController, animated: true)
        createTaskViewController.user_id = user.userId
        createTaskViewController.project_id = project_id
        createTaskViewController.isTaskObject = true
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let userCell = cell as! UserTableViewCell
        let user = tableItems.objectAtIndex(indexPath.row) as! User
        userCell.userName.text = user.userFirstName + " " + user.userLastName
        userCell.userTitle.text = user.userTitle
        userCell.userAvatar.downloadImageFromUrl(APIRoutes.BASE_IMGS + user.userProfilePictureSquareURL)
        userCell.userAvatar.makeCircular()
        
    }
    
  }
