//
//  TaskCommentModel.swift
//  Robustivity
//
//  Created by Mansour Said on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class TaskCommentModel: Object, Mappable {
    
    dynamic var commentId = 0
    dynamic var userId = 0
    dynamic var content = ""
    dynamic var taskId = 0
    dynamic var createdAt = ""
    dynamic var updatedAt = ""
    dynamic var projectId = 0
    dynamic var nature = ""
    dynamic var taskName = ""
    dynamic var attachementName = ""
    dynamic var milestoneName = ""
    dynamic var sprintName = ""
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        commentId           <- map["id"]
        userId              <- map["user_id"]
        content             <- map["content"]
        taskId              <- map["task_id"]
        createdAt           <- map["created_at"]
        updatedAt           <- map["updated_at"]
        projectId           <- map["project_id"]
        nature              <- map["nature"]
        taskName            <- map["task_name"]
        attachementName     <- map["attachment_name"]
        milestoneName       <- map["milestone_name"]
        sprintName          <- map["sprint_name"]
    }
}
