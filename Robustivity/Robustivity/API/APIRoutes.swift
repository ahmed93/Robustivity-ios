//
//  APIUrls.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 4/19/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

class APIRoutes {
    
    static let BASE = "http://hr.staging.rails.robustastudio.com/api/"
    static let URL = "http://hr.staging.rails.robustastudio.com/"
    static let BASE_IMGS = "http://hr.staging.rails.robustastudio.com"
    static let FEED_INDEX = "feeds/"
    static let TASKS_INDEX = "tasks/"
    static let TASKS_CREATE = "tasks"
    static let TODOS_CREATE = "todos/"
    static let USER_SHOW = "users/"
    static let USER_PROFILE = USER_SHOW + "profile/"
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