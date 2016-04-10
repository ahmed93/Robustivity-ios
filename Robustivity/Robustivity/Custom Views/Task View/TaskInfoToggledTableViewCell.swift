//
//  TaskInfoToggledTableViewCell.swift
//  Robustivity
//
//  Created by Mohammad Lotfy on 2016-04-02.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class TaskInfoToggledTableViewCell: SwipableTableViewCell {

    @IBOutlet weak var taskDate: RBLabel!
   
    @IBOutlet weak var timePhoto: UIImageView!
    @IBOutlet weak var taskName: RBLabel!
    @IBOutlet weak var timer: RBLabel!
    
    var hours:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    var realTimer:NSTimer = NSTimer()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timer.labelType = 1040;
        timer.textColor = Theme.greenColor()
        taskDate.labelType = 1070
        taskDate.textColor = Theme.redColor()
        taskName.labelType = 3020
        
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
        updateTimerLabel()
        
    }
    
    func updateTimerLabel(){
        timer.text = String(format: "%02d:%02d:%02d", hours,minutes,seconds)
    }
    
    func setTimer(){
        realTimer = NSTimer(timeInterval: 1.0, target: self, selector: "timerDidTick:", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(realTimer, forMode: NSRunLoopCommonModes)
    }
    
    override func playButtonAction() {
        setTimer()
    }
    override func pauseButtonAction() {
        realTimer.invalidate()
        updateTimerLabel()
        
    }
    override func stopButtonAction() {
        realTimer.invalidate()
        resetTime()
        updateTimerLabel()
        
    }
    
    func resetTime(){
        seconds = 0
        minutes = 0
        hours = 0
    }
}
