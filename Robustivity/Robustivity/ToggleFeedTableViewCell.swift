//
//  ToggleFeedTableViewCell.swift
//  Robustivity
//
//  Created by khaled elhossiny on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ToggleFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: RBLabel!
    var hours:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        let timer = NSTimer(timeInterval: 1.0, target: self, selector: "timerDidTick:", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func timerDidTick(timer:NSTimer){
        seconds++
        if seconds == 60 {
            minutes++
            seconds = 0
        }
        
        if minutes == 60{
            minutes = 0
            hours++
        }
        let time = String(format: "%02d:%02d:%02d", hours,minutes,seconds)
        timeLabel.text = time
        
    }
    
}
