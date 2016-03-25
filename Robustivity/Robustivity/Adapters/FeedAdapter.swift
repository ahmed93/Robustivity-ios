//
//  FeedAdapter.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class FeedAdapter: BaseTableAdapter {

    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        // any extra stuff to be done
    }
    
    
    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
        tableItems.addObject("new test")
        tableItems.addObject("new test 2")
        tableItems.addObject("new test 3")
        tableItems.addObject("new test 4")
        tableItems.addObject("new test 5")
        tableItems.addObject("new test 6")
        tableItems.addObject("new test 7")
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("feedViewController") as! FeedViewController
        viewController.navigationController?.pushViewController(controller, animated: true)
    }

    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? BaseTableViewCell
        
        _cell?.label.text = tableItems.objectAtIndex(indexPath.row) as? String
//        _cell?.imgView.image = UIImage(named: "call_blue")
        
    }
    
    
}
