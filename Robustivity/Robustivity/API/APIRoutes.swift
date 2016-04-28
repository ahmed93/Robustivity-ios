//
//  APIUrls.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 4/19/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

class APIRoutes {
    

    static let BASE = "http://hr.staging.rails.robustastudio.com/api/"

    static let USERS = "users/"
    static let USER_SHOW = BASE + USERS
    static let USER_PROFILE = USER_SHOW + "profile/"
    static let TOKEN_CREATE = BASE + USERS + "authenticate"

    static let TASKS_INDEX = "tasks/"
    
}