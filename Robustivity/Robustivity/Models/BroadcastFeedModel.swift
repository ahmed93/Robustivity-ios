//
//  BroadcastFeedModel.swift
//  Robustivity
//
//  Created by khaled elhossiny on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class BroadcastFeedModel: FeedModel {
    var user:UserModel?
    var title:String?
    
    init(user:UserModel, tiemStamp:String, content:String) {
        super.init(content:content, timeStamp:tiemStamp)
        self.user = user
        self.title = (self.user?.name)! + " sent a broadcast"
        self.content = content
    }
}
