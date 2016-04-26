//
//  TaskInfoModel.swift
//  Robustivity
//
//  Created by Mansour Said on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class TaskInfoModel: Object, Mappable {
    
    dynamic var taskId = 0
    dynamic var taskEstimatedTime = 0
    dynamic var taskRevisedTime = 0
    dynamic var taskActualTime = 0
    dynamic var taskName = ""
    dynamic var taskStatus = ""
    dynamic var taskUserId = 0
    dynamic var taskCreatorId = 0
    dynamic var taskCreatedAt = ""
    dynamic var taskUpdatedAt = ""
    dynamic var taskProjectId = 0
    dynamic var taskDescription = ""
    dynamic var taskGroupId = 0
    dynamic var taskStartDate = ""
    dynamic var taskNature = ""
    dynamic var taskPast = false
    dynamic var taskComments = []
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        taskId             <- map["id"]
        taskEstimatedTime  <- map["estimated_time"]
        taskRevisedTime    <- map["revised_time"]
        taskActualTime     <- map["actual_time"]
        taskName           <- map["name"]
        taskStatus         <- map["status"]
        taskUserId         <- map["user_id"]
        taskCreatorId      <- map["creator_id"]
        taskCreatedAt      <- map["created_at"]
        taskUpdatedAt      <- map["updated_at"]
        taskProjectId      <- map["project_id"]
        taskDescription    <- map["description"]
        taskGroupId        <- map["group_id"]
        taskStartDate      <- map["start_date"]
        taskNature         <- map["nature"]
        taskPast           <- map["past"]
        taskComments       <- map["comments"]
    }
}
