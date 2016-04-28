//
//  MyProject.swift
//  Robustivity
//
//  Created by Almgohar on 4/28/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class MyProject:Object, Mappable {
    
    dynamic var projectId = 0
    dynamic var projectName = ""
    dynamic var projectStatus = ""
    dynamic var projectManagerName = ""
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        projectId    <- map["id"]
        projectName         <- map["name"]
        projectStatus      <- map["status"]
        projectManagerName    <- map["project_manager_name"]
    }
    
    
}
