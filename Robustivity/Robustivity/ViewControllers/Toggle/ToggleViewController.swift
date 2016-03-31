//
//  ToggleViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ToggleViewController: BaseViewController {
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var recordedTime: UILabel!
    
    var timer = NSTimer();
    var startDate = NSDate();
    var pausedDate = NSDate();
    var currentTimeInterval = NSTimeInterval();
    @IBOutlet weak var todoTitle: UITextField!
    var pausedTimeInterval = NSTimeInterval();

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("ToggleViewController", owner: self, options: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Toggle";
        self.navigationItem.title = "Toggle";
        self.playBtn.layer.cornerRadius = 0.5 * self.playBtn.bounds.size.width;
        self.playBtn.backgroundColor = Theme.greenColor();
        self.pauseBtn.layer.cornerRadius = 0.5 * self.pauseBtn.bounds.size.width;
        self.pauseBtn.backgroundColor = Theme.greenColor();
        self.stopBtn.layer.cornerRadius = 0.5 * self.stopBtn.bounds.size.width;
        self.stopBtn.backgroundColor = Theme.redColor();

        self.recordedTime.text = "00:00:00";
        self.stopBtn.hidden = true;
        self.pauseBtn.hidden = true;
    }

    
    @IBAction func startPlay(sender: AnyObject) {
        let currentDate = NSDate();
        startDate = currentDate;
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true);
        
        self.recordedTime.textColor = Theme.greenColor();
        self.playBtn.hidden = true;
        self.pauseBtn.hidden = false;
        self.stopBtn.hidden = false;
        
    }
    func updateCounter() {
        // Create date from the elapsed time
        let currentDate = NSDate();
        
        var timeInterval = currentDate.timeIntervalSinceDate(self.startDate);
        timeInterval += pausedTimeInterval;

        let timerDate = NSDate(timeIntervalSince1970: timeInterval);
         // Create a date formatter
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "HH:mm:ss";
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0);
        let timeString = dateFormatter.stringFromDate(timerDate);
        self.currentTimeInterval = timeInterval;
        self.recordedTime.text = timeString;
        
    }
    @IBAction func pause(sender: AnyObject) {
        self.pausedDate = NSDate();
        timer.invalidate();
        self.recordedTime.textColor = Theme.blackColor();
        self.pausedTimeInterval = self.currentTimeInterval;
        self.pauseBtn.hidden = true;
        self.playBtn.hidden = false;
    }

    @IBAction func stop(sender: AnyObject) {
        self.pausedDate = NSDate();
        if(self.todoTitle.text == "") {
            let confirmToggleView = ConfirmToggleViewController();
            confirmToggleView.toggledTime = self.recordedTime.text!;
            self.navigationController?.pushViewController(confirmToggleView, animated: true);
        }
        timer.invalidate();
        ///MODIFY AND HANDLE THIS PART TO FIT THE BACK CASE
//        self.recordedTime.text = "00:00:00";
//        self.pausedTimeInterval = 0;
//        self.stopBtn.hidden = true;
//        self.pauseBtn.hidden = true;
//        self.playBtn.hidden = false;
    }

}
