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
    
    var toggleCellTask:TaskModel = TaskModel() //Aya
    let toggleHelper = ToggleHelper.sharedInstance


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timer.labelType = 1040;
        timer.textColor = Theme.greenColor()
        taskDate.labelType = 1070
        taskDate.textColor = Theme.redColor()
        taskName.labelType = 3020
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateToggledTimeNotification", name:"updateToggledTimeNotification", object: nil)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateToggledTimeNotification() {
        
        if (self.toggleHelper.toggleTask.taskId != self.toggleCellTask.taskId) {
            return
        }
        playButtonCellSetup()
        self.timer.text = toggleHelper.toggledTime
    }

    
    override func playButtonAction() {
        print("play")
        if(self.toggleHelper.toggleTask.taskId == 0) {
            return
        }
        self.toggleHelper.toggleTask = self.toggleCellTask
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
