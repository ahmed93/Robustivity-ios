//
//  ProjectUpdateAdapter.swift
//  Robustivity
//
//  Created by Nada Fadali on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectUpdateAdapter: BaseTableAdapter {
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // any extra stuff to be done
    }
    
    
    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
        
        let fillerText = "Lorem ipsum dolor sit amet, at per verear gubergren signiferumque. Et clita indoctum vel, fabulas iudicabit pro ad. Cum ut iusto mediocrem. Mazim munere deterruisset ea duo, pro no ubique quidam consetetur."
        
        tableItems.addObject(ProjectUpdateModel(name: "Ahmed", avatar: NSURL(fileURLWithPath: "ahmed") , time: "at 3:00 pm", content: fillerText))
        
        tableItems.addObject(ProjectUpdateModel(name: "Islam", avatar: NSURL(fileURLWithPath: "islam"), time: "at 2:00 pm", content: fillerText))
        
        tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(170)
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let productUpdateTableViewCell = cell as? ProjectUpdateTableViewCell
        
        let currentUpdateData = tableItems.objectAtIndex(indexPath.row) as! ProjectUpdateModel
        
        productUpdateTableViewCell?.userNameLabel.text = currentUpdateData.userName as String!
//        productUpdateTableViewCell?.userAvatarImageView.sd_setImageWithURL(currentUpdateData.userAvatar!);
        productUpdateTableViewCell?.updateTimeLabel.text = currentUpdateData.updateTime as String!
        productUpdateTableViewCell?.updateContentLabel.text = currentUpdateData.updateContnet as String!
        
    }
    
}

