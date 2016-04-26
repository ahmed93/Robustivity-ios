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
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    override static func primaryKey() -> String? {
        return "updateId"
    }
    
    func mapping(map: Map) {
        updateId <- map["comments.id"]
        userId <- map["comments.user_id"]
        updateContent <- map["comments.content"]
        taskId <- map["comments.task_id"]
        updateCreatedAt <- map["comments.created_at"]
        updateUpdatedAt <- map["comments.updated_at"]
        projectId <- map["comments.project_id"]
        updateNature <- map["comments.nature"]
        taskName <- map["comments.task_name"]
        attachmentName <- map["comments.attachment_name"]
        milestoneName <- map["comments.milestone_name"]
        sprintName <- map["comments.sprint_name"]
        
    }
    
    
}