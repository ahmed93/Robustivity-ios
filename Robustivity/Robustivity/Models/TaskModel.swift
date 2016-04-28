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

enum TaskType: String {
    case Task = "task"
    case Todo = "todo"
}

enum TaskStatus: String {
    case  NewlyCreated = "newly_created1"
    case  InProgress = "in_progress"
    case  Pending_Customer = "pending_customer"
    case  Completed = "completed"
    case  Closed = "closed"
    case  Reopened = "reopened"
}

class TaskModel: Object, Mappable {
    static let dateFormatter = NSDateFormatter()

    dynamic var taskId = 0
    dynamic var taskEstimatedTime = 0
    dynamic var taskRevisedTime = 0
    dynamic var taskActualTime = 0
    dynamic var taskName = ""
    dynamic var taskStatus = ""
    dynamic var taskUserId = 0
    dynamic var taskCreatorId = 0
    dynamic var taskCreatedAt:NSDate? = nil
    dynamic var taskUpdatedAt:NSDate? = nil
    dynamic var taskProjectId = 0
    dynamic var taskDescription = ""
    dynamic var taskGroupId = 0
    dynamic var taskStartDate:NSDate? = nil
    dynamic var taskNature = ""
    dynamic var taskPast = false
    
    required convenience init?(_ map: Map) {
        self.init()
    }

    override static func primaryKey() -> String? {
        return "taskId"
    }
    
    func mapping(map: Map) {
        TaskModel.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        taskId             <- map["id"]
        taskEstimatedTime  <- map["estimated_time"]
        taskRevisedTime    <- map["revised_time"]
        taskActualTime     <- map["actual_time"]
        taskName           <- map["name"]
        taskStatus         <- map["status"]
        taskUserId         <- map["user_id"]
        taskCreatorId      <- map["creator_id"]
        taskCreatedAt      <- (map["created_at"], DateFormatterTransform(dateFormatter: TaskModel.dateFormatter));
        taskUpdatedAt      <- (map["updated_at"], DateFormatterTransform(dateFormatter: TaskModel.dateFormatter));
        taskProjectId      <- map["project_id"]
        taskDescription    <- map["description"]
        taskGroupId        <- map["group_id"]
        
        TaskModel.dateFormatter.dateFormat = "yyyy-MM-dd"
        
        taskStartDate      <- (map["start_date"], DateFormatterTransform(dateFormatter: TaskModel.dateFormatter));
        taskNature         <- map["nature"]
        taskPast           <- map["past"]
    }

    static func createOrUpdate(tasks: [TaskModel]){
        let realm = try! Realm()
        try! realm.write {
            realm.add(tasks, update: true)
        }
    }
    
    static func recent(type: TaskType, status: TaskStatus...) -> Results<TaskModel> {
        var inAttr = status.reduce("{") { (str, value) -> String in
            str + "\'\(value.rawValue)\',"
        }
        inAttr = inAttr.substringToIndex(inAttr.endIndex.predecessor()) + "}"
        
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "taskNature = %@ AND taskStatus IN %@", type.rawValue, status.map { $0.rawValue })
        let result = realm.objects(self).filter(predicate).sorted("taskUpdatedAt", ascending: false)
        return result;
    }

}