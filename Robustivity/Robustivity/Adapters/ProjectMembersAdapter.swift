//
//  ProjectMembersAdapter.swift
//  Robustivity
//
//  Created by Abdelrahman Zaky on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectMembersAdapter: BaseTableAdapter{
    let preferences = NSUserDefaults.standardUserDefaults()

    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // any extra stuff to be done
    }
    
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let projectmembercell = cell as? ProjectMemberCell
        let currentUser = tableItems.objectAtIndex(indexPath.row) as! User

        projectmembercell?.nameLabel.text = currentUser.userFirstName  + " " + currentUser.userLastName
        if(currentUser.userTitle != ""){
           projectmembercell?.positionLabel.text = currentUser.userTitle
        }
        else {
            projectmembercell?.positionLabel.text = "No Title"
        }
        projectmembercell?.profileImageView.sd_setImageWithURL(NSURL(string: "http://hr.staging.rails.robustastudio.com" + currentUser.userProfilePictureIconURL))
        
        projectmembercell?.profileImageView.layer.cornerRadius = (projectmembercell?.profileImageView.frame.size.width)! / 2
        projectmembercell?.profileImageView.clipsToBounds = true
        
        projectmembercell?.userId = currentUser.userId
        
        projectmembercell?.user = currentUser
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(57)
    }
    
    
    func setProjectData(data:NSMutableArray) {
        tableItems.objects = data
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: NSBundle.mainBundle())
        //  var adapter:ProfileAdapter!
        let currentUser = tableItems.objectAtIndex(indexPath.row) as! User
            profileViewController.userId = currentUser.userId
            if(self.preferences.integerForKey("id") == currentUser.userId) {
                profileViewController.myProfile = true
            }else {
                profileViewController.myProfile = false
            }
            self.viewController.navigationController?.presentViewController(UINavigationController(rootViewController:profileViewController),animated: true, completion: nil)
           }
    
}

