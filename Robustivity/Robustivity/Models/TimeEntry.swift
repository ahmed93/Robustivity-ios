//
//  TimeEntry.swift
//  Robustivity
//
//  Created by Aya Amr on 4/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class TimeEntry: Object, Mappable {
    
    dynamic var timeEntryId = 0
    dynamic var timelogId = 0
    dynamic var timeEntryCreatedAt = ""
    dynamic var timeEntryUpdatedAt = ""
    dynamic var timeEntryStartedAt = ""
    dynamic var timeEntryEndedAt = ""
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    override static func primaryKey() -> String? {
        return "timeEntryId"
    }
    
    func mapping(map: Map) {
        
        timeEntryId <- map["id"]
        timelogId <- map["timelog_id"]
        timeEntryCreatedAt <- map["created_at"]
        timeEntryUpdatedAt <- map["updated_at"]
        timeEntryStartedAt <- map["started_at"]
        timeEntryEndedAt <- map["ended_at"]
    }
    
    func updateTimeEntry() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(self, update: true)
        }
    }
    
    
}