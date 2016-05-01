//
//  APIUrls.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 4/19/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

class APIRoutes {
    

    static let URL = "http://hr.staging.rails.robustastudio.com"
    
    static let BASE = URL + "/api/"
    
    static let BASE_IMGS = "http://hr.staging.rails.robustastudio.com"
    static let FEED_INDEX = "feeds/"
    static let TASKS_INDEX = "tasks/"
    static let TASKS_CREATE = "tasks"
    static let TODOS_CREATE = "todos/"
    static let USER_SHOW = "users/"
    static let USER_PROFILE = USER_SHOW + "profile/"
    
    static let USER_EDIT = USER_SHOW + "edit_profile/"
    
    static let USER_STATUS = USER_SHOW + "users_status/"
    
    static let BASE_NOTIFICATIONS = "http://hr.staging.rails.robustastudio.com"
    static let NOTIFICATIONS = "notifications/"
    static let NOTIFICATIONS_MARK_READ = "mark_as_read/"
    static let NOTIFICATIONS_RESET_MARK_READ = "reset_all/"
   

    static let WORKING_DAYS = "working_days/"
    static let ATTENDANCELOG = "working_days/attendance_log/"
    static let PROJECTS_INDEX = "projects/"
    static let TASKS_TIMELOG = TASKS_INDEX + "{task_id}/timelogs/"
    static let TASK_TIMELOG_PAUSE = TASKS_TIMELOG + "pause/"
    static let TASK_TIMELOG_RESUME = TASKS_TIMELOG + "resume/"
    static let TASK_TIMELOG_STOP = TASKS_TIMELOG + "stop/"
    static let TODO_CREATE = "todos/"
    static let PROJECTS_MYPROJECTS = "projects/my_projects/"
    static let PING_CREATE = "messages/"
    static let EXCUSES_INDEX = "excuses/"
    static let EXCUSES_CREATE = "excuses/"

}