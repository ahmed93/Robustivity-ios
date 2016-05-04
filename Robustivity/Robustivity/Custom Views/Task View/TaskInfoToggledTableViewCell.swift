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
    
    let toggleHelper = ToggleHelper.sharedInstance
    
    var toggleCellTask:TaskModel = TaskModel() //Aya
    
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
                self.pauseButtonCellSetup()
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
    
    static func playButtonCellConfiguration() -> [String] {
        return [TaskStatus.NewlyCreated.rawValue, TaskStatus.Paused.rawValue, TaskStatus.TodoItem.rawValue, TaskStatus.Closed.rawValue]
    }
    
    static func pauseButtonCellConfiguration() -> [String] {
        return [TaskStatus.InProgress.rawValue]
    }
 
}
