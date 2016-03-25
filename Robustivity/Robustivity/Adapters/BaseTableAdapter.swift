//
//  BaseTableAdaptor.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class BaseTableAdapter: BaseAdapter {
    
    var tableView:UITableView!
    var cellIdentifier:String!
    var viewController:UIViewController!
    
    init(viewController:UIViewController, tableView:UITableView, cellIdentifier:String) {
        super.init()
        self.cellIdentifier = cellIdentifier
        self.viewController = viewController
        self.tableView = tableView
        commonSetup()
    }
    
//    init(viewController:UIViewController, tableView:UITableView,registerCellWithClass cellClass:AnyClass, withIdentifier identifier:String) {
//        super.init()
//        self.tableView = tableView
//        self.cellIdentifier = identifier
//        self.tableView.registerClass(cellClass, forCellReuseIdentifier: identifier)
//        self.viewController = viewController
//        commonSetup()
//    }

    init(viewController:UIViewController, tableView:UITableView,registerCellWithNib name:String, withIdentifier identifier:String) {
        super.init()
        self.tableView = tableView
        self.cellIdentifier = identifier
        self.tableView.registerNib(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: identifier)
        self.viewController = viewController
        commonSetup()
    }
    
    func commonSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension

        
        tableItems = ListModel()
        reloadItems()
        tableView.backgroundColor = Theme.listBackgroundColor()
    }
}

extension BaseTableAdapter: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchModeEnabled {
            return searchTableViewList.count
        }else {
            return tableItems.count
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? UITableViewCell
        
        configure(cell!, indexPath: indexPath)
        return cell!
    }
    
    // Empty implementation to be overriden
    func configure(cell:UITableViewCell, indexPath:NSIndexPath) {
    }
}


