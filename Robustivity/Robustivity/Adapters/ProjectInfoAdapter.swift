//
//  ProjectInfoAdapter.swift
//  Robustivity
//
//  Created by Abanoub Aziz on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit


class ProjectInfoAdapter: BaseTableAdapter {
    
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // any extra stuff to be done
    }
    
    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
        tableItems.addObject(["member_name": "Ahmed Abousafy", "role" : "Account Manager", "type": "1"])
        tableItems.addObject(["member_name": "Islam Abdelraouf", "role" : "Projec Manager", "type": "1"])
        tableItems.addObject(["member_name": "Mohamed Fathy", "role" : "Spoc", "type": "2"])
        tableItems.addObject(["member_name": "$10000", "role" : "Billable Manager", "type": "3"])
        tableView.reloadData()
    }
    
    
    
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let projectInfoCell = cell as? ProjectMemberCell
        let currentCellData = tableItems.objectAtIndex(indexPath.row) as! NSDictionary
        
        projectInfoCell?.nameLabel.text = currentCellData.objectForKey("member_name") as? String
        projectInfoCell?.positionLabel.text = currentCellData.objectForKey("role") as? String
        switch(currentCellData.objectForKey("type") as! String) {
        case "3": projectInfoCell?.profileImageView.image = UIImage(named: "Stroke 2406 + Stroke 2407 + Stroke 2408")
        default: break;
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(57)
    }
    
    
    
}
