//
//  CreateTaskAdapter.swift
//  Robustivity
//
//  Created by Mohamed Bahgat Elrakaiby on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CreateTaskAdapter : BaseTableAdapter {
    
     override init(viewController: UIViewController, tableView: UITableView, registerMultipleNibsAndIdenfifers cellsNibs: NSDictionary) {
        super.init(viewController: viewController, tableView: tableView, registerMultipleNibsAndIdenfifers: cellsNibs)
        
    }
    
     func fetchItems() {
        
        tableItems.addObject(["textView":"Task Name (required)", "height":57]);
        tableItems.addObject(["label":"Due date" , "textView":"DD.MM.YYYY", "height" : 57]);
        tableItems.addObject(["textView":"Description (required)", "height":159]);
        
        tableView.separatorColor = Theme.tableBackgroundColor();
        tableView.reloadData();
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableItems.count;
    }
    
    override func configureViaMultipleIdentifiers(indexPath: NSIndexPath) -> UITableViewCell? {
        
        let cellProperties = tableItems.objectAtIndex(indexPath.section) as! NSDictionary;
        
        if(cellProperties.count == 2){
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("textView", forIndexPath: indexPath) as! TextViewTaskViewCell
            
            cell.textView.text = cellProperties.objectForKey("textView") as! String;
            cell.textView.autocorrectionType = UITextAutocorrectionType.No;
            
            return cell;
         
        }
        else{
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("label", forIndexPath: indexPath) as! LabelTextTaskViewCell;
            
            cell.label.text = cellProperties.objectForKey("label") as? String;
            cell.textView.text = cellProperties.objectForKey("textView") as! String;
            cell.textView.clearsOnInsertion = true;
            
            return cell;
        }
    
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat(5)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(0);
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView(frame: CGRectZero)
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView(frame: CGRectZero)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return CGFloat((tableItems.objectAtIndex(indexPath.section) as! NSDictionary).objectForKey("height") as! Int);
        
    }
}