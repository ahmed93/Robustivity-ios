//
//  Timelog.swift
//  Robustivity
//
//  Created by Aya Amr on 4/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Timelog: Object, Mappable {
    
    dynamic var timelogId = 0
    dynamic var timelogStatus = ""
    dynamic var timelogTaskId = 0
    dynamic var timelogCreatedAt = ""
    dynamic var timelogUpdatedAt = ""
    dynamic var timelogCurrentEntryId = 0
    dynamic var timelogStartedAt = ""
    dynamic var timelogEndedAt = ""
    dynamic var timelogDuration = 0
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }

    override static func primaryKey() -> String? {
        return "timelogId"
    }
    func mapping(map: Map) {
        
        timelogId <- map["id"]
        timelogStatus <- map["status"]
        timelogTaskId <- map["task_id"]
        timelogCreatedAt <- map["created_at"]
        timelogUpdatedAt <- map["ended_at"]
        timelogCurrentEntryId <- map["current_entry_id"]
        timelogStartedAt <- map["started_at"]
        timelogEndedAt <- map["ended_at"]
        timelogDuration <- map["duration"]
    }
    
    
}
