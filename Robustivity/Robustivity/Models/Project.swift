//
//  Project.swift
//  Robustivity
//
//  Created by khaled elhossiny on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//
import Foundation
import ObjectMapper
import RealmSwift

class Project: Object, Mappable {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var billable = false
    dynamic var status = ""
    dynamic var start_date = ""
    dynamic var created_at = ""
    dynamic var updated_at = ""
    dynamic var project_manager_id = 0
    dynamic var account_manager_id = 0
    dynamic var quotation = 0
    dynamic var account_id = 0
    dynamic var actual_cost = 0
    dynamic var planned_cost = 0
    dynamic var hourly_rate = 0
    dynamic var has_sprints = false
    dynamic var customer_statisfaction = ""
    dynamic var nature = ""
    dynamic var slug = ""
    dynamic var accounting_project_number = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                      <- map["id"]
        name                    <- map["name"]
        billable                <- map["billable"]
        status                  <- map["status"]
        start_date              <- map["start_date"]
        created_at              <- map["created_at"]
        updated_at              <- map["updated_at"]
        project_manager_id      <- map["project_manager_id"]
        account_manager_id      <- map["account_manager_id"]
        quotation               <- map["quotation"]
        account_id              <- map["account_id"]
        actual_cost             <- map["actual_cost"]
        planned_cost            <- map["planned_cost"]
        hourly_rate             <- map["hourly_rate"]
        has_sprints             <- map["has_sprints"]
        customer_statisfaction  <- map["customer_statisfaction"]
        nature                  <- map["nature"]
        slug                    <- map["slug"]
        accounting_project_number   <- map["accounting_project_number"]
    }
    
    func save(){
        let realm = try! Realm()
        for db_project in realm.objects(Project) {
            if db_project.id == self.id{
                return
            }
        }
        try! realm.write {
            realm.add(self)
        }
    }
    
    
}