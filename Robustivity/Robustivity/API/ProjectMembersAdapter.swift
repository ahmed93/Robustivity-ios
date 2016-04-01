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
    
    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
        tableItems.addObject(
            [
                "name"          :"Islam Ahmed",
                "position"      :"IT Manager",
                "image"      	:"Stroke 751 + Stroke 752"
            ])
            tableItems.addObject(
            [
            "name"          :"Islam Ahmed",
            "position"      :"IT Manager",
            "image"      	:"Stroke 751 + Stroke 752"
            ])
        tableView.reloadData()
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let projectmembercell = cell as? ProjectMemberCell
        
        let currentCellData = tableItems.objectAtIndex(indexPath.row) as! NSDictionary
        
        projectmembercell?.nameLabel.text = currentCellData.objectForKey("name") as? String
        projectmembercell?.positionLabel.text = currentCellData.objectForKey("position") as? String

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(57)
    }
    
}

