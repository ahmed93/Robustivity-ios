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
        
        tableItems.addObject(ProjectUpdateModel(name: "Ahmed", avatar: NSURL(fileURLWithPath: "image url"), time: "at 3:00 pm", content: "lorem ipsom here"))
        
        tableItems.addObject(ProjectUpdateModel(name: "Islam", avatar: NSURL(fileURLWithPath: "image url"), time: "at 2:00 pm", content: "lorem ipsom here"))
        
        tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? ProjectUpdateTableViewCell
        
        let currentUpdateData = tableItems.objectAtIndex(indexPath.row) as! ProjectUpdateModel
        
        _cell?.userNameLabel.text = currentUpdateData.userName as String!
        _cell?.userAvatarImageView.sd_setImageWithURL(currentUpdateData.userAvatar!);
        _cell?.updateTimeLabel.text = currentUpdateData.updateTime as String!
        _cell?.updateContentLabel.text = currentUpdateData.updateContnet as String!
        
    }
    
}

