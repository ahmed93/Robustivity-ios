//
//  ToggleTimerDelegate.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 5/2/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation


protocol ToggleTimerDelegate : AnyObject {
    func toggleTimer(timer: NSTimer)
}