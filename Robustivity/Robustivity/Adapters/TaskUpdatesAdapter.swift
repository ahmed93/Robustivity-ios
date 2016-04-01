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
        cell.comment.text = "this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome this task is awesome "
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
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row > 0{
            cell.contentView.backgroundColor = UIColor.clearColor()
            
            let whiteRoundedView : UIView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 5))
            
            whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
            whiteRoundedView.layer.masksToBounds = false
            whiteRoundedView.layer.cornerRadius = 2.0
            whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
            whiteRoundedView.layer.shadowOpacity = 0.2
            
            cell.contentView.addSubview(whiteRoundedView)
            cell.contentView.sendSubviewToBack(whiteRoundedView)
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 51
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
