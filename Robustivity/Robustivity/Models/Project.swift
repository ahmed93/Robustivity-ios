//
//  Project.swift
//  Robustivity
//
//  Created by Aya Amr on 4/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Project: Object, Mappable {
    
    dynamic var projectId = 0
    dynamic var projectName = ""
    dynamic var projectIsBillable = false
    dynamic var projectStatus = ""
    dynamic var projectStartDate = ""
    dynamic var projectEndDate = ""
    dynamic var projectCreatedAt = ""
    dynamic var projectUpdatedAt = ""
    dynamic var projectManagerId = 0
    dynamic var accountManagerId = 0
    dynamic var projectQuotation = 0
    dynamic var projectAccountId = 0
    dynamic var projectActualCost = 0
    dynamic var projectPlannedCost = 0
    dynamic var projectHourlyRate = 0
    dynamic var projectHasSprints = false
    dynamic var projectCustomerSatisfaction = ""
    dynamic var projectNature = ""
    dynamic var projectSlug = ""
    dynamic var projectAccountingNumber = 0
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    override static func primaryKey() -> String? {
        return "projectId"
    }
    
    func mapping(map: Map) {
        
        projectId <- map["id"]
        projectName <- map["name"]
        projectIsBillable <- map["billable"]
        projectStatus <- map["status"]
        projectStartDate <- map["start_date"]
        projectEndDate <- map["end_date"]
        projectCreatedAt <- map["created_at"]
        projectUpdatedAt <- map["updated_at"]
        projectManagerId <- map["project_manager_id"]
        accountManagerId <- map["account_manager_id"]
        projectQuotation <- map["quotation"]
        projectAccountId <- map["account_id"]
        projectActualCost <- map["actual_cost"]
        projectPlannedCost <- map["planned_cost"]
        projectHourlyRate <- map["hourly_rate"]
        projectHasSprints <- map["has_sprints"]
        projectCustomerSatisfaction <- map["customer_statisfaction"]
        projectNature <- map["nature"]
        projectSlug <- map["slug"]
        projectAccountingNumber <- map["accounting_project_number"]
    }
    
    
}