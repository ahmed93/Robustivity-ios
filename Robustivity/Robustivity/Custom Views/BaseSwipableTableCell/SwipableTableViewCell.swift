//
//  Swipable.swift
//  Robustivity
//
//  Created by Mahmoud Eldesouky on 3/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

/* ANY CLASS THAT NEEDS THE 'SWIPE TO TOGGLE FUNCTIONALITY SHOULD EXTEND THIS SUPER CLASS' */
//SwipableTableViewCell is a TableViewCell that have the 'Swipe To Toggle' functionality. The class allows to swipe the cell left for play/pause, and right for stop toggeling. 
//You have to ovveride the play/pause/stop action functions
//You can edit the width via the padding

class SwipableTableViewCell: MGSwipeTableCell {
    weak var tableView:UITableView?
    
    let playImage : UIImage = UIImage(named:"play.png")!
    let pauseImage : UIImage = UIImage(named:"pause.png")!
    let stopImage : UIImage = UIImage(named:"stop.png")!

    var playMode : Bool
    var playPauseButton : MGSwipeButton
    var stopButton : MGSwipeButton
    
    required init?(coder aDecoder: NSCoder) {

        playMode = false
       
        stopButton = MGSwipeButton(title: "", icon: stopImage, backgroundColor: Theme.redColor(),padding: 30)
        
        
        playPauseButton = MGSwipeButton(title: "", icon: playImage, backgroundColor: Theme.greenColor(),padding: 30)
        
        super.init(coder: aDecoder)
        self.setButtonsActions()
        self.leftButtons = [stopButton]
        self.rightButtons = [playPauseButton]
    }
    
    
    func setButtonsActions() {
        
        playPauseButton.callback = {
            (sender: MGSwipeTableCell!) -> Bool in
            // do Stuff
            self.playMode = false
            self.playButtonConfigure()
            self.refreshButtons(false)
            return true
        }
        stopButton.callback = {
            (sender: MGSwipeTableCell!) -> Bool in
            // do Stuff
            self.playMode = true
            self.stopButtonConfigure()
            self.refreshButtons(false)
            return true
        }
    }
    
    func playButtonConfigure() {
        playButtonAction()
        playButtonCellSetup()

    }
    func playButtonCellSetup() {
        
        playPauseButton = MGSwipeButton(title: "", icon: pauseImage, backgroundColor: Theme.grayColor(),padding: 30)
        
        playPauseButton.callback = {
            (sender: MGSwipeTableCell!) -> Bool in
            // do Stuff
            self.playMode = false
            self.pauseButtonConfigure()
            return true
        }
        
        self.rightButtons = [self.playPauseButton]
        self.refreshButtons(false)
        
    }
    func pauseButtonConfigure() {
        pauseButtonAction()
        pauseButtonCellSetup()
        
    }
    func pauseButtonCellSetup() {
        
        playPauseButton = MGSwipeButton(title: "", icon: playImage, backgroundColor: Theme.greenColor(),padding: 30)
        playPauseButton.callback = {
            (sender: MGSwipeTableCell!) -> Bool in
            // do Stuff
            self.playMode = false
            self.playButtonConfigure()
            return true
        }
        
        self.rightButtons = [self.playPauseButton]
        self.refreshButtons(false)
        
    }
    func stopButtonConfigure() {
        stopButtonAction()
        stopButtonCellSetup()

    }
    
    func stopButtonCellSetup() {
        playPauseButton = MGSwipeButton(title: "", icon: playImage, backgroundColor: Theme.greenColor(),padding: 30)
        playPauseButton.callback = {
            (sender: MGSwipeTableCell!) -> Bool in
            // do Stuff
            self.playMode = false
            self.playButtonConfigure()
            return true
        }
        
        self.rightButtons = [self.playPauseButton]
        self.refreshButtons(false)
        
    }
    
    // Empty implementation to be overriden
    func playButtonAction() {
        NSLog("Play")
    }
    func pauseButtonAction() {
        NSLog("Pause")
    }
    func stopButtonAction() {
        NSLog("Stop")
    }
    
    
 
}
