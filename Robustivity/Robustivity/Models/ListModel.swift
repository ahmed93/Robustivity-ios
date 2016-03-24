//
//  RobustivityModel.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/22/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ListModel: BaseModel {
    
    var items:NSMutableArray!
    var searchItems:NSMutableArray!
    var selectedItemIndex:NSIndexPath!
    var isSearchMode:Bool = false
    
    override init() {
        super.init()
        items = NSMutableArray()
        searchItems = NSMutableArray()
        
        
    }
    
    func objectAtIndex(index:Int)-> AnyObject? {
        if isSearchMode
        {
            return searchItems.objectAtIndex(index)
        }
        else
        {
            return items.objectAtIndex(index)
        }

    }
    
    
    func count() -> Int {
        if isSearchMode
        {
            return searchItems.count
        }
        else
        {
            return items.count
        }
    }

    
}
