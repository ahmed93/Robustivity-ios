//
//  TaskInfoAdapter.swift
//  Robustivity
//
//  Created by Mohammad Lotfy on 2016-03-30.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
class TaskInfoAdapter: BaseTableAdapter{
    override init(viewController: UIViewController, tableView: UITableView, registerMultipleNibsAndIdenfifers cellsNibs:NSDictionary) {
        super.init(viewController: viewController, tableView: tableView, registerMultipleNibsAndIdenfifers: cellsNibs)
        
        // any extra stuff to be done
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? BaseTableViewCell
        
        _cell?.label.text = tableItems.objectAtIndex(indexPath.row) as? String
    }

    override func configureViaMultipleIdentifiers(indexPath:NSIndexPath)->UITableViewCell? {
       if indexPath.section == 0 || indexPath.section == 1{
             let cell = self.tableView.dequeueReusableCellWithIdentifier("personCell", forIndexPath: indexPath)
                as! PersonTableViewCell
            cell.name.text = "Mohamed Lotfy"
            cell.position.text = "CEO and co-founder"
        
        return cell
        
       }
        else{
            let cell = self.tableView.dequeueReusableCellWithIdentifier("descriptionCell", forIndexPath: indexPath)
                as! DescriptionTableViewCell
            cell.taskDescription.text = "I have a big task waiting I have a big task waiting I have a big task waiting \n I have a big task waitingI have a big task waitingI have a big task waiting"
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
 //for hiding the first section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//        return 1.0
//        }
        return 45.0
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName = String()
        switch(section){
        case 0:
            sectionName =  "Assigned by"
            break
        case 1:
            sectionName = "Assigned to"
            break
        case 2:
            sectionName = "Description"
            break
        default:
            sectionName = ""
            break
        }
        return sectionName
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 114
    }
}
