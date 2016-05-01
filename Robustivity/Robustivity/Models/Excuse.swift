//
//  ExcuseModel.swift
//  Robustivity
//
//  Created by Abdelrahman Saad  on 4/27/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Excuse: Object, Mappable {
    
    dynamic var excuseId = 0
    dynamic var excuseBody = ""
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        excuseId    <- map["id"]
        excuseBody  <- map["body"]
    }
    
    
}