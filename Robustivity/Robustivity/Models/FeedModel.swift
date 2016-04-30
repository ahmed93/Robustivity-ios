//
//  FeedModel.swift
//  Robustivity
//
//  Created by khaled elhossiny on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class FeedModel: Object, Mappable {
    
    dynamic var content = ""
    dynamic var timeStamp = ""
    dynamic var type = ""
    dynamic var profilePicture = ""
    dynamic var userName = ""
    dynamic var feedId = 0
    
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        content     <- map["message"]
        timeStamp  <- map["created_at"]
        type        <- map["type"]
        userName <- map["user.first_name"]
        profilePicture    <- map["user.profile_picture.url"]
        feedId <- map["id"]
        
    }
    
    
}
