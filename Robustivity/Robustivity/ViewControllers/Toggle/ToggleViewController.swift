//
//  ToggleViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ToggleViewController: BaseViewController {

    @IBOutlet weak var recordedTime: UILabel!
    var timer = NSTimer()
    var counter = 0
    var startDate = NSDate()
    
    @IBAction func startPlay(sender: AnyObject) {
        let currentDate = NSDate()
        startDate = currentDate
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        
    }
    func updateCounter() {
        // Create date from the elapsed time
        let currentDate = NSDate()
        
        let timeInterval = currentDate.timeIntervalSinceDate(self.startDate)
        let timerDate = NSDate(timeIntervalSince1970: timeInterval)
//        let timerDate = NSDate(timeInterval: timeInterval, sinceDate: startDate  )
         // Create a date formatter
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
//        dateFormatter.timeZone = NSTimeZone
        let timeString = dateFormatter.stringFromDate(timerDate);
        self.recordedTime.text = timeString;
        
        
        
        // Create a date formatter
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
//        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        
        // Format the elapsed time and set it to the label
//        NSString *timeString = [dateFormatter stringFromDate:timerDate];
//        self.stopwatchLabel.text = timeString;
        
//        recordedTime.text = String(counter++)
    }
    @IBAction func pause(sender: AnyObject) {
         timer.invalidate()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("ToggleViewController", owner: self, options: nil)
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Toggle";
        self.navigationItem.title = "Toggle";
    }


}
