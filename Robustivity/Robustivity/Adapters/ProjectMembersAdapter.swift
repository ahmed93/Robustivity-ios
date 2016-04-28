//
//  ProjectMembersAdapter.swift
//  Robustivity
//
//  Created by Abdelrahman Zaky on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectMembersAdapter: BaseTableAdapter{
    

    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // any extra stuff to be done
    }
    
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let projectmembercell = cell as? ProjectMemberCell
        let currentUser = tableItems.objectAtIndex(indexPath.row) as! User
       // print(currentUser)

        projectmembercell?.nameLabel.text = currentUser.userFirstName  + " " + currentUser.userLastName
        print(currentUser.userTitle)
//        projectmembercell?.positionLabel.text  = "asd"
        if(currentUser.userTitle != ""){
           projectmembercell?.positionLabel.text = currentUser.userTitle
        }
        else {
            projectmembercell?.positionLabel.text = "No title"
        }
//        projectmembercell?.positionLabel.text = currentUser.userTitle
        projectmembercell?.profileImageView.sd_setImageWithURL(NSURL(string: "http://hr.staging.rails.robustastudio.com" + currentUser.userProfilePictureIconURL))
        
        projectmembercell?.profileImageView.layer.cornerRadius = (projectmembercell?.profileImageView.frame.size.width)! / 2
        projectmembercell?.profileImageView.clipsToBounds = true
        
        projectmembercell?.userId = currentUser.userId
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(57)
    }
    
}

