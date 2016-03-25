//
//  BaseAdapter.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/22/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

@objc protocol BaseAdapterDelegate {

    
    optional func fetchItems()
    optional func fetchMoreItems()
}

class BaseAdapter: NSObject, BaseAdapterDelegate {
    
    var tableItems:ListModel!
    var searchTableViewList:ListModel!
    var searchModeEnabled:Bool = false
    
    
    func reloadItems() {
        if self.respondsToSelector(NSSelectorFromString("fetchItems")) {
            self.performSelector(NSSelectorFromString("fetchItems"))
        }
    }
    
}
