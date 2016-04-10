//
//  TaskUpdatesAdapter.swift
//  Robustivity
//
//  Created by Mohammad Lotfy on 2016-03-30.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

/*
Table adapter for the table in the task updates view
extends BaseTableAdapter via registerCellWithNib constructor
returns 1 cell type: commentCell
the table footer is edited to have a textfield and a button to submit new comments
*/

import UIKit
class TaskUpdatesAdapter: BaseTableAdapter{
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        // any extra stuff to be done
    }
  
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? BaseTableViewCell
        
        _cell?.label.text = tableItems.objectAtIndex(indexPath.row) as? String
    }
    
    override func configureViaMultipleIdentifiers(indexPath: NSIndexPath) -> UITableViewCell? {
        return nil
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
            as! CommentTableViewCell
        cell.name.text = "Mansour Said Mansour"
        cell.comment.text = "This task is so awesome that I am doing it 2 times in a row. I am happy, smiling and blessed. god bless MURICA"
        cell.time.text = "Yesterday"
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}
