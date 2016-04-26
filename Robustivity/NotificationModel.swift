//
//  NotificationModel.swift
//  Robustivity
//
//  Created by Ali Soliman on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//


import Foundation
import ObjectMapper
import RealmSwift

class NotificationModel: Object, Mappable {
    

    dynamic var notificationActorName = ""
    dynamic var notificationActorProfilePictureURL = ""
    dynamic var notificationBody = ""
    dynamic var notificationCreationDate = ""
    dynamic var notificationProjectName = ""
    dynamic var notificationURL = ""
    dynamic var notificationType = ""
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        notificationActorName                 <- map["actor_name"]
        notificationActorProfilePictureURL    <- map["actor_profile_picture"]
        notificationBody                      <- map["body"]
        notificationCreationDate              <- map["created_at"]
        notificationProjectName               <- map["project_name"]
        notificationURL                       <- map["url"]
        notificationType = (notificationURL.characters.split{$0 == "/"}.map(String.init))[0]
    }
    
    
}
