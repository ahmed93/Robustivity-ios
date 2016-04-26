//
//  User.swift
//  Robustivity
//
//  Created by khaled elhossiny on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class User: Object, Mappable {
    dynamic var id = 0
    dynamic var email = ""
    dynamic var created_at = ""
    dynamic var updated_at = ""
    dynamic var first_name = ""
    dynamic var last_name = ""
    dynamic var mobile_number = ""
    dynamic var address = ""
    dynamic var title = ""
    dynamic var joined_date = ""
    dynamic var employment_type = ""
    dynamic var manager_id = 0
    dynamic var team_id = 0
    dynamic var work_email = ""
    dynamic var contact_person_name = ""
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map){
        id                      <- map["id"]
        email                    <- map["email"]
        created_at                <- map["created_at"]
        updated_at                  <- map["updated_at"]
        first_name              <- map["first_name"]
        last_name              <- map["last_name"]
        mobile_number              <- map["mobile_number"]
        address      <- map["address"]
        title      <- map["title"]
        joined_date               <- map["joined_date"]
        employment_type              <- map["employment_type"]
        manager_id             <- map["manager_id"]
        team_id            <- map["team_id"]
        work_email             <- map["work_email"]
        contact_person_name   <- map["contact_person_name"]
    }
    
    
}

