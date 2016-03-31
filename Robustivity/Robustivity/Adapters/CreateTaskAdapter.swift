//
//  CreateTaskAdapter.swift
//  Robustivity
//
//  Created by Mohamed Bahgat Elrakaiby on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CreateTaskAdapter : BaseTableAdapter {
    
    
    let headerHeight  = CGFloat(50);
    
     override init(viewController: UIViewController, tableView: UITableView, registerMultipleNibsAndIdenfifers cellsNibs: NSDictionary) {
        super.init(viewController: viewController, tableView: tableView, registerMultipleNibsAndIdenfifers: cellsNibs)
        
    }
    
     func fetchItems() {
        
        tableItems.addObject([
            
            ["textView", "Task Name (required)"],
            
            [["label", "Due date"],["textView", "DD.MM.YYYY"]],
            
            "textView", "Description (required)"]
        );
        
        tableView.reloadData();
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableItems.objectAtIndex(0)!.count;
    }
    
    override func configureViaMultipleIdentifiers(indexPath: NSIndexPath) -> UITableViewCell? {
        
        let identifier = "myCell";
        
        let cellInfo = tableItems.objectAtIndex(indexPath.section) as! NSDictionary;
        
        if(cellInfo.count == 1){
            
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! TextViewTaskViewCell
            
            cell.textView.text = cellInfo.objectForKey("textView") as! String;
            
            return cell;
         
        }
        else{
            
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! LabelTextTaskViewCell;
            
            cell.label.text = cellInfo.objectForKey("label") as? String;
            cell.textView.text = cellInfo.objectForKey("textView") as! String;
            
            return cell;
        }
    
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: headerHeight))
        
        return headerView;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(200);
    }
}