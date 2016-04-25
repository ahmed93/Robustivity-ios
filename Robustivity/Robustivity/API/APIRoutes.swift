//
//  APIUrls.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 4/19/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

class APIRoutes {
    

    static let BASE = "http://hr.staging.rails.robustastudio.com/api/"
    
    static let TASKS_INDEX = "tasks/"
    
    static let USER_SHOW = "users/"
    static let USER_PROFILE = USER_SHOW + "profile/"
    
    static let PROJECTS_INDEX = "projects/"
    
    static let TASKS_TIMELOG = TASKS_INDEX + "{task_id}/timelogs/"
    
    static let TASK_TIMELOG_PAUSE = TASKS_TIMELOG + "pause/"
    
    
   
    
}