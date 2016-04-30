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
    var selectedUsers:Dictionary<Int, String> = [:]
    var deselectedUsers:Dictionary<Int,String> = [:]

    
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
        self.selectedUsers[currentUser.userId] = currentUser.userProfilePictureURL

        if(self.deselectedUsers[currentUser.userId] != nil) {
            self.deselectedUsers.removeValueForKey(currentUser.userId)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let _cell = cell as! PingToUserTableViewCell
        for user in Ping.selectedUsers.keys {
            if(_cell.userId == user) {
                _cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            }
        }

    }
    
        
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        let currentUser = tableItems.objectAtIndex(indexPath.row) as! User
        if(self.selectedUsers[currentUser.userId] != nil) {
            self.selectedUsers.removeValueForKey(currentUser.userId)
        }
        
        if(self.deselectedUsers[currentUser.userId] == nil) {
            self.deselectedUsers[currentUser.userId] = currentUser.userProfilePictureURL
        }
    }
    
    
    
    
}
