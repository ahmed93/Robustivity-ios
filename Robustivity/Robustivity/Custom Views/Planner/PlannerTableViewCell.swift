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
    @IBOutlet weak var clockImage: UIImageView!
    
    @IBOutlet weak var dueDateBottomMarginLayoutConstraint: NSLayoutConstraint!
    //
    var plannerCellTask:TaskModel = TaskModel() //Aya
    var toggleManager = ToggleManager.sharedInstance
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellSeparator.backgroundColor = Theme.tableBackgroundColor()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func playButtonAction() {
        print("play")
        
        toggleManager.playNewTask(self.plannerCellTask, onSuccess: { [unowned self] () in
            self.tableView?.reloadData()
            })
    }
    
    override func pauseButtonAction() {
        print("pause")
        toggleManager.pauseCurrentTask({ [unowned self] () in
            self.pauseButtonCellSetup()
            self.clockImage.highlighted = false
            self.toggleTimer.text = self.toggleManager.stringFromTimeInterval(Double(self.plannerCellTask.taskDuration))
            })
    }
    
    override func stopButtonAction() {
        print("stop")
        toggleManager.stopCurrentTask( { [unowned self] () in
            self.stopButtonCellSetup()
            self.clockImage.highlighted = false
            self.toggleTimer.text = self.toggleManager.stringFromTimeInterval(Double(self.plannerCellTask.taskDuration))
            })
    }
    
    static func playButtonCellConfiguration() -> [String] {
        return [TaskStatus.NewlyCreated.rawValue, TaskStatus.Paused.rawValue, TaskStatus.TodoItem.rawValue, TaskStatus.Closed.rawValue]
    }
    
    static func pauseButtonCellConfiguration() -> [String] {
        return [TaskStatus.InProgress.rawValue]
    }
}
