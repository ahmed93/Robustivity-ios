//
//  BaseTableAdaptor.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class BaseTableAdapter: NSObject {
    
    var tableView:UITableView!
    var tableItems:NSMutableArray!
    var cellClass:AnyClass!
    var cellIdentifier:String!
    
    init(tablView:UITableView, cellIdentifier:String) {
        super.init()

    }
    
    init(tableView:UITableView,withCellClass cellClass:AnyClass, withCellIdentifier cellID:String) {
        super.init()
        
        self.tableView = tableView
        self.cellClass = cellClass
        self.cellIdentifier = cellID
        self.tableView.estimatedRowHeight = 120
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
}

extension BaseTableAdapter: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell!
        
        if self.respondsToSelector(Selector("configureCell:")) {
            print("isHere")
        }
        
        return cell
    }
}

extension BaseTableAdapter: UITableViewDelegate {
    
}

