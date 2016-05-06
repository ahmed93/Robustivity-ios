//
//  ToggleTimerDelegate.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 5/2/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation

@objc protocol ToggleManagerDelegate : AnyObject {
    func toggleManager(toggleManager: ToggleManager, hasTask task: TaskModel, toggledTime: String)
    func toggleManager(toggleManager: ToggleManager, didChangeToggledTask task: TaskModel, toggledTime: String)

    optional func toggleManager(toggleManager: ToggleManager, didUpdateTimer value: String)
    optional func toggleManager(toggleManager: ToggleManager, willStartTimer toggledTime: String, forTask task: TaskModel)
    optional func toggleManager(toggleManager: ToggleManager, didStartTimer toggledTime: String, forTask task: TaskModel)
    
    optional func toggleManager(toggleManager: ToggleManager, willPauseTimer toggledTime: String, forTask task: TaskModel)
    optional func toggleManager(toggleManager: ToggleManager, didPauseTimer toggledTime: String, forTask task: TaskModel)
    
    optional func toggleManager(toggleManager: ToggleManager, willStopTimer toggledTime: String, forTask task: TaskModel)
    optional func toggleManager(toggleManager: ToggleManager, didStopTimer toggledTime: String, forTask task: TaskModel)
}