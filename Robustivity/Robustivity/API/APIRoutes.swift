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
    static let PING_CREATE = "messages/"
    static let SHOW_PROJECT = "projects/"
    static let EXCUSES_INDEX = "excuses/"
    static let EXCUSES_CREATE = "excuses/"
    static let PROJECTS_INDEX = "projects/"

    static let MY_PROJECTS = "projects/my_projects/";
    
    static let PROJECT_UPDATE = PROJECTS_INDEX + "1/updates"
    

}