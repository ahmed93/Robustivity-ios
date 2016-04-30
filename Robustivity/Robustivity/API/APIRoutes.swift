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
    
    static let TASKS_INDEX = "tasks/"
    
    static let USER_SHOW = "users/"
    
    static let USER_PROFILE = USER_SHOW + "profile/"
    
    static let USER_EDIT = USER_SHOW + "edit_profile/"
    
    static let USER_STATUS = USER_SHOW + "users_status/"
    
    static let BASE_NOTIFICATIONS = "http://hr.staging.rails.robustastudio.com"
    static let NOTIFICATIONS = "notifications/"
    static let NOTIFICATIONS_MARK_READ = "mark_as_read/"
    static let NOTIFICATIONS_RESET_MARK_READ = "reset_all/"
   
    
    
}