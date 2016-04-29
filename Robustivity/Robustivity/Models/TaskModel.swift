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

// Ahmed Elassuty
enum TaskType: String {
    case Task = "task"
    case Todo = "todo"
}

// Ahmed Elassuty
// Should be refactored to be global on the application
enum TaskStatus: String {
    case  NewlyCreated = "newly_created"
    case  InProgress   = "in_progress"
    case  Paused       = "paused"
    case  Closed       = "closed"
    case  TodoItem     = "todo_item"
    
    
    static func configurationOf(type: TaskType) -> (inProgress: [TaskStatus], done: [TaskStatus])? {
        switch type {
        case .Task:
            return TaskConfigurations()
        case .Todo:
            return TodoConfigurations()
        }
    }
    
    private static func TaskConfigurations () -> (inProgress: [TaskStatus], done: [TaskStatus]) {
        return ([.NewlyCreated, .InProgress, .Paused], [.Closed])
    }
    
    private static func TodoConfigurations () -> (inProgress: [TaskStatus], done: [TaskStatus]) {
        return ([.TodoItem, .InProgress, .Paused], [.Closed])
    }
}

// Ahmed Elassuty
// Class Name should be changed to accomodate Tasks and Todos
class TaskModel: Object, Mappable {
    // Should be global on the app
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
    dynamic var userName = ""
    dynamic var userAvatar = ""
    dynamic var userTitle = ""
    dynamic var creatorName = ""
    dynamic var creatorAvatar = ""
    dynamic var creatorTitle = ""
    dynamic var taskProjectName = ""

    
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
        userName           <- map["user_name"]
        userAvatar         <- map["user_profile_picture"]
        userTitle          <- map["user_title"]
        creatorName        <- map["creator_name"]
        creatorAvatar      <- map["creator_profile_picture"]
        creatorTitle       <- map["creator_title"]
        taskProjectName    <- map["project_name"]
    }

    static func createOrUpdate(tasks: [TaskModel]){
        let realm = try! Realm()
        try! realm.write {
            realm.add(tasks, update: true)
        }
    }
    
    static func recent(type: TaskType, status: [TaskStatus]!) -> Results<TaskModel> {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "taskNature = %@ AND taskStatus IN %@", type.rawValue, status.map { $0.rawValue })
        let result = realm.objects(self).filter(predicate).sorted("taskUpdatedAt", ascending: false)
        return result;
    }
    
    static func filterAll(type: TaskType, startsWith text: String) -> Results<TaskModel> {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "taskNature = %@ AND taskName CONTAINS[c] %@", type.rawValue, text)
        let result = realm.objects(self).filter(predicate).sorted("taskUpdatedAt", ascending: false)
        return result;
        
    }

}