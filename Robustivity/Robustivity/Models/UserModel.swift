//
//  UserModel.swift
//  Robustivity
//
//  Created by khaled elhossiny on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class UserModel: BaseModel {
    var avatar:NSURL?
    var name:String?
    
    init(avatar:NSURL, name:String) {
        self.avatar = avatar
        self.name = name
    }
}
