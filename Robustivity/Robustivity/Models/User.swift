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
    dynamic var contact_person_phone = ""
    dynamic var contact_person_relation = ""
    dynamic var contact_person_address = ""
    dynamic var invitation_token = ""
    dynamic var invitation_created_at = ""
    dynamic var invitation_sent_at = ""
    dynamic var invitation_accepted_at = ""
    dynamic var invitation_limit = ""
    dynamic var invited_by_id = ""
    dynamic var invited_by_type = ""
    dynamic var invitations_count = 0
    dynamic var city = ""
    dynamic var daily_msg = ""
    dynamic var negative_msg = false
    dynamic var leader_id = 0
    dynamic var deleted_at = ""
    dynamic var acted_grade_id = 0
    dynamic var actual_grade_id = 0
    dynamic var avg_arrival_time = 0
    dynamic var profile_picture:ProfilePicture!
    
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
        contact_person_phone   <- map["contact_person_phone"]
        contact_person_relation   <- map["contact_person_relation"]
        contact_person_address   <- map["contact_person_address"]
        invitation_token   <- map["invitation_token"]
        invitation_created_at   <- map["invitation_created_at"]
        invitation_sent_at   <- map["invitation_sent_at"]
        invitation_accepted_at   <- map["invitation_accepted_at"]
        invitation_limit   <- map["invitation_limit"]
        invited_by_id   <- map["invited_by_id"]
        invited_by_type   <- map["invited_by_type"]
        invitations_count   <- map["invitations_count"]
        city   <- map["city"]
        daily_msg   <- map["daily_msg"]
        negative_msg   <- map["negative_msg"]
        leader_id   <- map["leader_id"]
        deleted_at   <- map["deleted_at"]
        acted_grade_id   <- map["acted_grade_id"]
        actual_grade_id   <- map["actual_grade_id"]
        avg_arrival_time   <- map["avg_arrival_time"]
        profile_picture   <- map["profile_picture"]
    }
    
    
}

