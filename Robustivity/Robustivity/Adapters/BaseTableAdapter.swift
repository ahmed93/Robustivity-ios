//
//  BaseTableAdaptor.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class BaseTableAdapter: BaseAdapter {
    
    var tableItems:ListModel!
    var searchTableViewList:ListModel?
    var tableView:UITableView!
    var cellIdentifier:String!
    
    init(tablView:UITableView, cellIdentifier:String) {
        super.init()
        self.cellIdentifier = cellIdentifier
        commonSetup()
    }
    
    init(tableView:UITableView,registerCellWithClass cellClass:AnyClass, withIdentifier identifier:String) {
        super.init()
        self.tableView = tableView
        self.cellIdentifier = identifier
        self.tableView.registerClass(cellClass, forCellReuseIdentifier: identifier)
        
        commonSetup()
    }

    init(tableView:UITableView,registerCellWithNib name:String, withIdentifier identifier:String) {
        super.init()
        self.tableView = tableView
        self.cellIdentifier = identifier
        self.tableView.registerNib(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: identifier)
        
        commonSetup()
    }
    
    func commonSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableItems = ListModel()
        
    }
    
    func reloadItems() {

    }
    
}

extension BaseTableAdapter: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell!
        
        configure(cell, indexPath: indexPath)
        return cell
    }
    
    
    // Empty implementation to be overriden
    func configure(cell:UITableViewCell, indexPath:NSIndexPath) {}
}

extension BaseTableAdapter: UITableViewDelegate {
    
}


