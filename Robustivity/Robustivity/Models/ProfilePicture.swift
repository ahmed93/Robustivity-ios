//
//  ProfilePicture.swift
//  Robustivity
//
//  Created by khaled elhossiny on 4/27/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ProfilePicture: Object, Mappable {
    dynamic var url = ""
    dynamic var profile = ""
    dynamic var square = ""
    dynamic var icon = ""
    dynamic var notifications = ""
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map){
        url <- map["url"]
        profile <- map["profile"]["url"]
        square <- map["square"]["url"]
        icon <- map["icon"]["url"]
        notifications <- map["notifications"]["url"]
    }
}
