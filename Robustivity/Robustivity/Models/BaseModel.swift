//
//  BaseModel.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/22/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

@objc protocol BaseModelDelegate {
    optional func initWithDictionary(dictionary:NSDictionary)-> AnyObject
    optional func modelName()->String
}

class BaseModel: NSObject, BaseModelDelegate {
    var modelID:Int?
    var createdData:String?
    var modifiedDate:String?
}
