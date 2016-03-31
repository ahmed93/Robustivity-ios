//
//  ProjectUpdateModel.swift
//  Robustivity
//
//  Created by Nada Fadali on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectUpdateModel: BaseModel {
    var userName:String?
    var userAvatar:NSURL?
    var updateTime:String?
    var updateContnet:String?
    
    init(name:String, avatar:NSURL, time:String, content:String) {
        super.init()
        
        self.userName = name
        self.userAvatar = avatar
        self.updateTime = time
        self.updateContnet = content
    }
    
    
}
