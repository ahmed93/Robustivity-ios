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
    @IBOutlet weak var taskName: RBLabel!
    
    @IBOutlet weak var projectName: UILabel!
    
    var toggleCellTask:TaskModel = TaskModel() //Aya

    
    let toggleHelper = ToggleHelper.sharedInstance

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func playButtonAction() {
        print("play")
        if(self.toggleHelper.toggleTask.taskId == 0) {
            return
        }
        self.toggleHelper.toggleResumeAction()
        
    }
    override func pauseButtonAction() {
        print("pause")
        if(self.toggleHelper.toggleTask.taskId == 0) {
            return
        }
        self.toggleHelper.togglePauseAction()
        
    }
    override func stopButtonAction() {
        print("stop")
        if(self.toggleHelper.toggleTask.taskId == 0) {
            return
        }
        self.toggleHelper.toggleStopAction()
        
    }
    
    
}
