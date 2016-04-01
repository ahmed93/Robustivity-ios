//
//  CheckInFeedModel.swift
//  Robustivity
//
//  Created by khaled elhossiny on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CheckInFeedModel: FeedModel {
    var user:UserModel?
    
    init(user:UserModel, tiemStamp:String) {
        super.init(content:"", timeStamp:tiemStamp)
        self.user = user
        self.timeStamp = timeStamp
        self.content? = (self.user?.name)! + " has just Checked In"
    }
}
