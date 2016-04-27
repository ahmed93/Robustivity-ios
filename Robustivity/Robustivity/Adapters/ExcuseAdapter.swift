//
//  ExcuseAdapter.swift
//  Robustivity
//
//  Created by Abdelrahman Saad  on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class ExcuseAdapter: BaseTableAdapter {
    
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        // any extra stuff to be done
    }
    
    
    func fetchItems() { // fetching the items through a get request
        if tableItems.count == 0 {
            tableItems = ListModel()
            API.get( APIRoutes.EXCUSES_INDEX, callback: { (success, response) in
                
                if(success){
                    let excuses = Mapper<Excuse>().mapArray(response)
                    for excuse in excuses! {
                        print(excuse.excuseBody)
                        self.tableItems.addObject(excuse)
                        self.saveNewExcuse(excuse)
                        
                    }
                    self.tableView.reloadData()
                }
                
                
                })
            
            
        }
    }
    
    func saveNewExcuse(excuse: Excuse) { // the save excuses function which stores the new excuses
        let realm = try! Realm()
        let savedexcuses = realm.objects(Excuse)
        //check if already exists on the database or not
        for checkexcuse in savedexcuses {
            if checkexcuse.excuseId == excuse.excuseId{
                return
            }
        }
        try! realm.write {
            realm.add(excuse)
        }
    }
    
    
    
    var selectedCell:UITableViewCell?{
        willSet{
            selectedCell?.accessoryType = .None
            newValue?.accessoryType = .Checkmark
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCell = self.tableView.cellForRowAtIndexPath(indexPath)
    }
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? ExcuseTableViewCell
        let excuse = tableItems.objectAtIndex(indexPath.row) as! Excuse
        _cell?.label.text = excuse.excuseBody
    }
    
    
}

