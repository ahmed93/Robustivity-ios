//
//  Project.swift
//  Robustivity
//
//  Created by Abanoub Aziz on 4/27/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Project: Object, Mappable {
    dynamic var projectId = 0
    dynamic var projectName:String = ""
    dynamic var projectEndDate:String = ""
    dynamic var projectIsBillable:Bool = false
    dynamic var projectBillableAmount:Double = 0.0
    dynamic var projectStatus:String = ""
    dynamic var projectManagerName = ""
    dynamic var projectManagerAvatar = ""
    dynamic var projectAccountManagerName = ""
    dynamic var projectAccountManagerAvatar = ""
    dynamic var projectSponserName = ""
    dynamic var projectSponserAddress = ""
    dynamic var projectSponserPhone = ""
    dynamic var projectNumberOfTasks = 0
    dynamic var projectTasksDone = 0
    dynamic var projectQuotation = 0
    dynamic var projectCustomerStatisfaction = ""
    dynamic var projectActualCost = 0
    dynamic var projectPlannedCost = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        projectId                           <- map["id"]
        projectName                         <- map["name"]
        projectIsBillable                   <- map["billable"]
        projectStatus                       <- map["status"]
        projectEndDate                      <- map["end_date"]
        projectManagerName                  <- map["project_manager_name"]
        projectManagerAvatar                <- map["project_manager_profile_picture"]
        projectAccountManagerName           <- map["account_manager_name"]
        projectAccountManagerAvatar         <- map["account_manager_profile_picture"]
        projectSponserName                  <- map["spoonsor_name"]
        projectSponserAddress               <- map["spoonsor_address"]
        projectSponserPhone                 <- map["sponsor_phone"]
        projectQuotation                    <- map["quotation"]
        projectCustomerStatisfaction        <- map["customer_statisfaction"]
        projectActualCost                   <- map["actual_cost"]
        projectPlannedCost                  <- map["planned_cost"]
    }
    
}
