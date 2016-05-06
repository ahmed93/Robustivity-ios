//
//  ToggleTimerDelegate.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 5/2/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation

@objc protocol ToggleTimerDelegate : AnyObject {
    func toggleManager(toggleManager: ToggleHelper, hasTask task: TaskModel, toggledTime: String)
    func toggleManager(toggleManager: ToggleHelper, didChangeToggledTask task: TaskModel, toggledTime: String)

    optional func toggleManager(toggleManager: ToggleHelper, didUpdateTimer value: String)
    optional func toggleManager(toggleManager: ToggleHelper, willStartTimer toggledTime: String, forTask task: TaskModel)
    optional func toggleManager(toggleManager: ToggleHelper, didStartTimer toggledTime: String, forTask task: TaskModel)
    
    optional func toggleManager(toggleManager: ToggleHelper, willPauseTimer toggledTime: String, forTask task: TaskModel)
    optional func toggleManager(toggleManager: ToggleHelper, didPauseTimer toggledTime: String, forTask task: TaskModel)
    
    optional func toggleManager(toggleManager: ToggleHelper, willStopTimer toggledTime: String, forTask task: TaskModel)
    optional func toggleManager(toggleManager: ToggleHelper, didStopTimer toggledTime: String, forTask task: TaskModel)
}