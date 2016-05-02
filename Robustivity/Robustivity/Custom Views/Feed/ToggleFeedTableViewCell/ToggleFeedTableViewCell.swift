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
        self.toggleHelper.toggleTask = self.toggleCellTask
        self.toggleHelper.toggleResumeAction({ () in
            self.playButtonCellSetup()
        })
        
    }
    override func pauseButtonAction() {
        print("pause")
        
        if(self.toggleCellTask.taskId == self.toggleHelper.toggleTask.taskId) {
            self.toggleHelper.togglePauseAction({ () in
                self.pauseButtonAction()
            })
            
        }
        
    }
    override func stopButtonAction() {
        print("stop")
        if(self.toggleCellTask.taskId == self.toggleHelper.toggleTask.taskId) {
            
            self.toggleHelper.toggleStopAction({ () in
                self.stopButtonCellSetup()
            })
            
        }
        
    }
    
    
}
