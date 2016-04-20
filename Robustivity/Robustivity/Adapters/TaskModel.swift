//
//  TaskModel.swift
//  Robustivity
//
//  Created by Mahmoud Eldesouky on 4/19/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class TaskModel: Object, Mappable {
    
    dynamic var taskId = ""
    dynamic var taskEstimatedTime = ""
    dynamic var taskRevisedTime = ""
    dynamic var taskActualTime = ""
    dynamic var taskName = ""
    dynamic var taskStatus = ""
    dynamic var taskUserId = ""
    dynamic var taskCreatorId = ""
    dynamic var taskCreatedAt = ""
    dynamic var taskUpdatedAt = ""
    dynamic var taskProjectId = ""
    dynamic var taskDescription = ""
    dynamic var taskGroupId = ""
    dynamic var taskStartDate = ""
    dynamic var taskNature = ""
    dynamic var taskPast = ""
    
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
    }
}