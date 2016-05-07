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
    
    let toggleManager = ToggleManager.sharedInstance
    
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
        toggleManager.resumeCurrentTask({ () in
            self.playButtonCellSetup()
        })
    }
    
    override func pauseButtonAction() {
        print("pause")
        toggleManager.pauseCurrentTask({ () in
            self.stopButtonCellSetup()
        })
    }
    
    override func stopButtonAction() {
        print("Stop")
        toggleManager.stopCurrentTask({ () in
            self.stopButtonCellSetup()
        })
    }
    
    static func playButtonCellConfiguration() -> [String] {
        return [TaskStatus.NewlyCreated.rawValue, TaskStatus.Paused.rawValue, TaskStatus.TodoItem.rawValue, TaskStatus.Closed.rawValue]
    }
    
    static func pauseButtonCellConfiguration() -> [String] {
        return [TaskStatus.InProgress.rawValue]
    }
    
    
}
