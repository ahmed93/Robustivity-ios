//
//  PlannerTableViewCell.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 3/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
/**
    PlannerTableViewCell subclass of SwipableTableViewCell. This cell can be used for both Tasks and My ToDos in the PlannerViewController.
    - Author:
        Ahmed Elassuty.
    - Date  :
        3/31/16.
    - Note  :
        - This cell is used for both Done and In Progress table sections by setting dueDate label text to an empty string. The cell handles the height automatically by adjusting the bottom constraint of the dueDate label based on the design.
 */
class PlannerTableViewCell: SwipableTableViewCell {
    @IBOutlet weak var itemTitle:RBLabel!
    @IBOutlet weak var projectName:RBLabel!
    @IBOutlet weak var toggleTimer:RBLabel!
    @IBOutlet weak var dueDate:RBLabel!
    @IBOutlet weak var cellSeparator: UIView!

    @IBOutlet weak var dueDateBottomMarginLayoutConstraint: NSLayoutConstraint!
//    
    var plannerCellTask:TaskModel = TaskModel() //Aya
    var toggleHelper = ToggleHelper.sharedInstance
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        cellSeparator.backgroundColor = Theme.tableBackgroundColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pauseTimerNotification", name:"pauseTimerNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopTimerNotification", name:"stopTimerNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resumeTimerNotification", name:"resumeTimerNotification", object: nil)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func resumeTimerNotification() {
        if self.plannerCellTask.taskId == self.toggleHelper.toggleTask.taskId {
            self.playButtonCellSetup()
        }else{
            self.pauseButtonCellSetup()
        }
    }
    func stopTimerNotification() {
        if self.plannerCellTask.taskId == self.toggleHelper.toggleTask.taskId {
            self.stopButtonCellSetup()
        }
    }
    
    
    func pauseTimerNotification() {
        if self.plannerCellTask.taskId == self.toggleHelper.toggleTask.taskId {
            print("pause Notification")
            self.pauseButtonCellSetup()
        }

    }
    
    override func playButtonAction() {
        print("play")
        self.toggleHelper.toggleTask = self.plannerCellTask
        self.toggleHelper.toggleResumeAction()
        
    }
    override func pauseButtonAction() {
        print("pause")
        if(self.plannerCellTask.taskId == self.toggleHelper.toggleTask.taskId) {
            self.toggleHelper.togglePauseAction()

        }
        
    }
    override func stopButtonAction() {
        print("stop")
        if(self.plannerCellTask.taskId == self.toggleHelper.toggleTask.taskId) {
            self.toggleHelper.toggleStopAction()            
        }
        
    }
    
    
}
