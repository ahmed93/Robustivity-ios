//
//  UserModel.swift
//  Robustivity
//
//  Created by Mansour Said on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import RealmSwift

class User: Object, Mappable {
    dynamic var userId = 0
    dynamic var userEmail = ""
    dynamic var userFirstName = ""
    dynamic var userLastName = ""
    dynamic var userMobileNumber = ""
    dynamic var userAddress = ""
    dynamic var userTitle = ""
    dynamic var userContactPersonName = ""
    dynamic var userContactPersonPhone = ""
    dynamic var userContactPersonRelation = ""
    dynamic var userContactPersonAddress = ""
    dynamic var userProfilePictureURL = ""
    dynamic var userProfilePictureProfileURL = ""
    dynamic var userProfilePictureSquareURL = ""
    dynamic var userProfilePictureIconURL = ""
    dynamic var userProfilePictureNotificationURL = ""
    dynamic var userCity = ""
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        userId                              <- map["id"]
        userEmail                           <- map["email"]
        userFirstName                       <- map["first_name"]
        userLastName                        <- map["last_name"]
        userMobileNumber                    <- map["mobile_number"]
        userAddress                         <- map["address"]
        userTitle                           <- map["title"]
        userContactPersonName               <- map["contact_person_name"]
        userContactPersonPhone              <- map["contact_person_phone"]
        userContactPersonRelation           <- map["contact_person_relation"]
        userContactPersonAddress            <- map["contact_person_address"]
        userProfilePictureURL               <- map["profile_picture.url"]
        userProfilePictureProfileURL        <- map["profile_picture.profile.url"]
        userProfilePictureSquareURL         <- map["profile_picture.square.url"]
        userProfilePictureIconURL           <- map["profile_picture.icon.url"]
        userProfilePictureNotificationURL   <- map["profile_picture.notifications.url"]
        userCity                            <- map["city"]
    }
}
