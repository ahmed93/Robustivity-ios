//
//  WorkingDay.swift
//  Robustivity
//
//  Created by Jihan Adel on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//
//  Edited by: Jihan Adel & Majd el shebokshy


import Foundation
import ObjectMapper
import RealmSwift


class WorkingDay: Object, Mappable {
    var id:Int = 0
    var createdAt:String = ""
    var updatedAt:String = ""
    var checkIn:String? = ""
    var checkOut:String? = ""
    var date:String = ""
    var userId:Int = 0
    var cch:Int? = 0
    var lateReason:String? = ""
        
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id         <- map["id"]
        checkIn    <- map["check_in"]
        checkOut   <- map["check_out"]
        date       <- map["date"]
        createdAt  <- map["created_at"]
        updatedAt  <- map["updated_at"]
        userId     <- map["user_id"]
        cch        <- map["cch"]
        lateReason <- map["late_reason"]
    }

}