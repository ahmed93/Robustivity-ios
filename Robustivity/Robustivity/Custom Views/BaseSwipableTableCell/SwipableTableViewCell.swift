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

    let playImage : UIImage = UIImage(named:"play.png")!
    let pauseImage : UIImage = UIImage(named:"pause.png")!
    let stopImage : UIImage = UIImage(named:"stop.png")!

    var playMode : Bool
    var playButton : MGSwipeButton
    var pauseButton : MGSwipeButton
    var stopButton : MGSwipeButton
    
    required init?(coder aDecoder: NSCoder) {

        playMode = false
       
        stopButton = MGSwipeButton(title: "", icon: stopImage, backgroundColor: Theme.redColor(),padding: 30)
        
        
        playButton = MGSwipeButton(title: "", icon: playImage, backgroundColor: Theme.greenColor(),padding: 30)
        
        pauseButton = MGSwipeButton(title: "", icon: pauseImage, backgroundColor: Theme.grayColor(),padding: 30)

       // pauseButton.hidden = true
        super.init(coder: aDecoder)
        self.setButtonsActions()
        self.leftButtons = [stopButton]
        self.rightButtons = [playButton]
    }
    
    
    func setButtonsActions() {
        
        pauseButton.callback = {
            (sender: MGSwipeTableCell!) -> Bool in
            // do Stuff
            self.playMode = true
            self.pauseButtonConfigure()
            self.refreshButtons(false)
            return true
        }
        playButton.callback = {
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
        self.rightButtons = [self.pauseButton]
        self.leftButtons = [self.stopButton]
    }
    func pauseButtonConfigure() {
        pauseButtonAction()
        self.rightButtons = [self.playButton]
        self.leftButtons = [self.stopButton]
    }
    func stopButtonConfigure() {
        stopButtonAction()
        self.rightButtons = [self.playButton]
        self.leftButtons = [self.stopButton]
    }
    
    // Empty implementation to be overriden
    func playButtonAction() {
        assertionFailure("\n======> You didn't Implement playButton func\n")
    }
    func pauseButtonAction() {
        assertionFailure("\n======> You didn't Implement pauseButton func\n")
    }
    func stopButtonAction() {
        assertionFailure("\n======> You didn't Implement playButton func\n")
    }
    
    
 
}
