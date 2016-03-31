//
//  TaskUpdatesAdapter.swift
//  Robustivity
//
//  Created by Mohammad Lotfy on 2016-03-30.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
class TaskUpdatesAdapter: BaseTableAdapter{
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        // any extra stuff to be done
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? BaseTableViewCell
        
        _cell?.label.text = tableItems.objectAtIndex(indexPath.row) as? String
    }
}
