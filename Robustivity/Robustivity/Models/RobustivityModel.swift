//
//  RobustivityModel.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/22/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class RobustivityModel: BaseModel {
    
    var items:NSMutableArray?
    var searchListItems:NSMutableArray?
    var selectedItemIndex:NSIndexPath?
    var isSearchMode:Bool = false
    
    
    func objectAtIndex(index:Int)-> AnyObject? {
        if isSearchMode
        {
            return searchListItems?.objectAtIndex(index)
        }
        else
        {
            return items?.objectAtIndex(index)
        }

    }
    
    
    func count() -> Int? {
        if isSearchMode
        {
            return searchListItems?.count
        }
        else
        {
            return items?.count
        }
    }

    
}
