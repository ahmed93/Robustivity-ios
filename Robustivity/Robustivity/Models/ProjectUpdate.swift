//
//  ProjectUpdate.swift
//  Robustivity
//
//  Created by Nada Fadali on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ProjectUpdate: Object, Mappable {
    
    dynamic var updateId = 0
    dynamic var userId = 0
    dynamic var updateContent = ""
    dynamic var taskId = 0
    dynamic var updateCreatedAt = ""
    dynamic var updateUpdatedAt = ""
    dynamic var projectId = 0
    dynamic var updateNature = ""
    dynamic var taskName = ""
    dynamic var attachmentName = ""
    dynamic var milestoneName = ""
    dynamic var sprintName = ""
    dynamic var userName = ""
    dynamic var userAvatar = ""
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    override static func primaryKey() -> String? {
        return "updateId"
    }
    
    func mapping(map: Map) {

        updateId <- map["id"]
        userId <- map["user_id"]
        updateContent <- map["content"]
        taskId <- map["task_id"]
        updateCreatedAt <- map["created_at"]
        updateUpdatedAt <- map["updated_at"]
        projectId <- map["project_id"]
        updateNature <- map["nature"]
        taskName <- map["task_name"]
        attachmentName <- map["attachment_name"]
        milestoneName <- map["milestone_name"]
        sprintName <- map["sprint_name"]
        userName <- map["user_name"]
        userAvatar <- map["user_profile_picture"]
        
    }
    
    //save new projectUpdate on disk using realm
    func saveDb() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(self, update: true)
        }
        
    }
    
    
}