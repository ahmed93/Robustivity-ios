//
//  ToggleFeedTableViewCell.swift
//  Robustivity
//
//  Created by khaled elhossiny on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ToggleFeedTableViewCell: SwipableTableViewCell {

    @IBOutlet weak var timeLabel: RBLabel!
    var hours:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    var timer:NSTimer = NSTimer()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*
    Made by Khaled Elhossiny
    this function is for updating time
    */
    
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
        updateTimerLabel()
        
    }
    
    func updateTimerLabel(){
        timeLabel.text = String(format: "%02d:%02d:%02d", hours,minutes,seconds)
    }
    
    func setTimer(){
        timer = NSTimer(timeInterval: 1.0, target: self, selector: "timerDidTick:", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    override func playButtonAction() {
        setTimer()
    }
    override func pauseButtonAction() {
        timer.invalidate()
        updateTimerLabel()
        
    }
    override func stopButtonAction() {
        timer.invalidate()
        resetTime()
        updateTimerLabel()
        
    }
    
    func resetTime(){
        seconds = 0
        minutes = 0
        hours = 0
    }
    
}
