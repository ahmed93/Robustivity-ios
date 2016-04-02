//
//  FeedModel.swift
//  Robustivity
//
//  Created by khaled elhossiny on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class FeedModel: BaseModel {
    var content:String?
    var timeStamp:String?
    
    init(content:String, timeStamp:String){
        self.content = content
        self.timeStamp = timeStamp
    }
    
    override init() {
        super.init()
    }
}
