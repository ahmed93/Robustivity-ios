//
//  APIUrls.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 4/19/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

class APIRoutes {
    

    static let BASE = "http://hr.staging.rails.robustastudio.com/api/"
    static let BASE_IMGS = "http://hr.staging.rails.robustastudio.com"
    
    static let TASKS_INDEX = "tasks/"
    static let TASKS_CREATE = "tasks"
    
    static let TODOS_CREATE = "todos/"
    
    static let USER_SHOW = "users/"
    static let USER_PROFILE = USER_SHOW + "profile/"
    
    static let PROJECTS_MYPROJECTS = "projects/my_projects/"
    
    static let PING_CREATE = "messages/"
    static let EXCUSES_INDEX = "excuses/"
    static let EXCUSES_CREATE = "excuses/"
    static let PROJECTS_INDEX = "projects/"

}