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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame:CGRectMake(0,0,320,40))
        footerView.backgroundColor = Theme.lightGrayColor()
        let commentButton = UIButton(type: .Custom)
        commentButton.setTitle("Comment", forState: .Normal)
        Theme.style_11(commentButton.titleLabel!)
        commentButton.setTitleColor(Theme.blueColor(), forState: .Normal)
        commentButton.backgroundColor = Theme.whiteColor()
        commentButton.addTarget(self, action: nil, forControlEvents: .TouchUpInside)
        commentButton.frame = CGRectMake(UIScreen.mainScreen().bounds.width - 100, 0, 100, 51)
        footerView.addSubview(commentButton)
        
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width - commentButton.frame.width, height: 51))
        textfield.placeholder = "   Write Comment Here..."
        textfield.backgroundColor = Theme.whiteColor()
        footerView.addSubview(textfield)
        
        return footerView
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 51
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
