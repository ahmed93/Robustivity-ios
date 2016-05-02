//
//  ToggleTimerDelegate.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 5/2/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation

@objc protocol ToggleTimerDelegate : AnyObject {
    optional func toggleTimer(timer: NSTimer, didUpdateTimerWithValue: String)
    optional func toggleTimer(timer: NSTimer, didStartTimer: String)
    optional func toggleTimer(timer: NSTimer, didPauseTimer: Bool)
}