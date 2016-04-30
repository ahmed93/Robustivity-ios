//
//  Project.swift
//  Robustivity
//
//  Created by khaled elhossiny & Abanoub Aziz on 4/26/16.
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
    dynamic var projectStartDate = ""
    dynamic var projectCreatedAt = ""
    dynamic var projectUpdatedAt = ""
    dynamic var projectManagerId = 0
    dynamic var projectAccountManagerId = 0
    dynamic var projectAccountId = 0
    dynamic var projectHourlyRate = 0
    dynamic var projectHasSprints = false
    dynamic var projectNature = ""
    dynamic var projectSlug = ""
    dynamic var projectAccountingProjectNumber = 0
    
    
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
        projectStartDate                    <- map["start_date"]
        projectCreatedAt                    <- map["created_at"]
        projectUpdatedAt                    <- map["updated_at"]
        projectManagerId                    <- map["project_manager_id"]
        projectAccountManagerId             <- map["account_manager_id"]
        projectAccountId                    <- map["account_id"]
        projectHourlyRate                   <- map["hourly_rate"]
        projectHasSprints                   <- map["has_sprints"]
        projectNature                       <- map["nature"]
        projectSlug                         <- map["slug"]
        projectAccountingProjectNumber      <- map["accounting_project_number"]
    }
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    override static func primaryKey() -> String? {
        return "projectId"
    }
    
    func save(){
        let realm = try! Realm()
        
        try! realm.write {
            
            realm.add(self, update: true)
        }
    }


}