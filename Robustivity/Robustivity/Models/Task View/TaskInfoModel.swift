//
//  TaskInfoModel.swift
//  Robustivity
//
//  Created by Mansour Said on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class TaskInfoModel: Object, Mappable {
    
    dynamic var tasks = ""
    dynamic var comments = ""
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        tasks             <- map["tasks"]
        comments          <- map["comments"]
    }
}
