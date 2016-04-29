//
//  PingAdapter.swift
//  Robustivity
//
//  Created by Almgohar on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import ObjectMapper

class PingAdapter: BaseTableAdapter {
    
    let realm = try! Realm()
    var selectedUsers:Array<Int> = []
    var selectedUsersPics:Array<String> = []
    var deselectedUsers:Array<Int> = []
    var deselectedUsersPics:Array<String> = []
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
          }
    
    
    func fetchItems() {
         if tableItems.count == 0 {
            API.get(APIRoutes.USER_SHOW, callback: { (success, response) in
                if(success){
                    //map the json object to the model and save them
                    let users = Mapper<User>().mapArray(response)
                    for user in users! {
                        self.tableItems.objects.addObject(user)
                    }
                    
                }
                self.tableView.reloadData()
            })
            
        }
        

    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? PingToUserTableViewCell
        let currentUser = tableItems.objectAtIndex(indexPath.row) as! User
        _cell?.pingUserName.text = currentUser.userFirstName  + " " + currentUser.userLastName
        _cell?.pingUserTitle.text = currentUser.userTitle
        _cell?.pingUserAvatar.sd_setImageWithURL(NSURL(string: "http://hr.staging.rails.robustastudio.com" + currentUser.userProfilePictureIconURL))
        _cell?.pingUserAvatar.layer.cornerRadius = (_cell?.pingUserAvatar.frame.size.width)! / 2
        _cell?.pingUserAvatar.clipsToBounds = true
        _cell?.userId = currentUser.userId
        _cell?.accessoryType = UITableViewCellAccessoryType.None

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        let currentUser = tableItems.objectAtIndex(indexPath.row) as! User
        self.selectedUsersPics.append(currentUser.userProfilePictureIconURL)
        self.selectedUsers.append(currentUser.userId)
        if(self.deselectedUsers.contains(currentUser.userId)) {
            self.deselectedUsers.removeAtIndex(self.deselectedUsers.indexOf(currentUser.userId)!)
        }
        
        if(self.deselectedUsersPics.contains(currentUser.userProfilePictureURL)) {
            self.deselectedUsersPics.removeAtIndex(self.deselectedUsersPics.indexOf(currentUser.userProfilePictureURL)!)
        }
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let _cell = cell as! PingToUserTableViewCell
        for user in Ping.selectedUsers {
            if(_cell.userId == user) {
                _cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            }
        }

    }
    
        
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        let currentUser = tableItems.objectAtIndex(indexPath.row) as! User
        if(self.selectedUsersPics.contains(currentUser.userProfilePictureURL)) {
            self.selectedUsersPics.removeAtIndex(self.selectedUsersPics.indexOf(currentUser.userProfilePictureIconURL)!)
        }
        if(self.selectedUsers.contains(currentUser.userId)) {
            self.selectedUsers.removeAtIndex(self.selectedUsers.indexOf(currentUser.userId)!)
        }
        if(!self.deselectedUsers.contains(currentUser.userId)) {
            self.deselectedUsers.append(currentUser.userId)
        }
        if(!self.deselectedUsersPics.contains(currentUser.userProfilePictureURL)) {
            self.deselectedUsersPics.append(currentUser.userProfilePictureURL)
        }
    }
    
    
    
    
}
