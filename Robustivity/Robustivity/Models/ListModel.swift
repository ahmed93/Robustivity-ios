//
//  RobustivityModel.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/22/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ListModel: NSObject {
    
    var objects:NSMutableArray!
    var selectedItemIndex:NSIndexPath!
    
    var currentPage:NSInteger?
    var lastPage:NSInteger?
    var objectsPrePage:NSInteger?
    
    var count:Int {
        get {
            return objects.count
        }
    }
    
    override init() {
        super.init()
        objects = NSMutableArray()
    }
    
    func objectAtIndex(index:Int)-> AnyObject? {
        return objects.objectAtIndex(index)
    }
        
    func removeObjectAtIndex(index:Int) {
        objects.removeObjectAtIndex(index)
    }
    func reverse() {
        self.objects = objects.reverse() as! NSMutableArray
    }
    
    func addObject(object:AnyObject) {
        objects.addObject(object)
    }
    
    func hasMorePages()->Bool {
        return currentPage < lastPage
    }
        
}
