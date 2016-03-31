//
//  ToggleViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ToggleViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var resumeBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var recordedTime: UILabel!

    @IBOutlet weak var todoTitleField: UITextField!
    @IBOutlet weak var todoProjectPicker: UIPickerView!
    
    var confirmToggleView = ConfirmToggleViewController();
    var timer = NSTimer();
    var startDate = NSDate();
    var pausedDate = NSDate();
    var currentTimeInterval = NSTimeInterval();
    var pausedTimeInterval = NSTimeInterval();
    
    var todoProjectPickerDataSource = ["Project name", "Farmraiser", "LMS", "Innovation Portal", "Maill buddy"];

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
        self.pauseBtn.backgroundColor = Theme.lighterBlackColor();
        self.stopBtn.layer.cornerRadius = 0.5 * self.stopBtn.bounds.size.width;
        self.stopBtn.backgroundColor = Theme.redColor();
        self.resumeBtn.layer.cornerRadius = 0.5 * self.resumeBtn.bounds.size.width;
        self.resumeBtn.backgroundColor = Theme.greenColor();

        self.buttonsView.hidden = true;

        self.recordedTime.text = "00:00:00";
        
        self.todoTitleField.backgroundColor = Theme.lightGrayColor();
        self.todoTitleField.placeholder = "ToDo title"
        self.todoProjectPicker.backgroundColor = Theme.lightGrayColor();
        self.todoProjectPicker.dataSource = self;
        self.todoProjectPicker.delegate = self;

    }
    
    @IBAction func startPlay(sender: AnyObject) {
        let currentDate = NSDate();
        startDate = currentDate;
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true);
        
        self.recordedTime.textColor = Theme.greenColor();
        Theme.style_8(self.recordedTime)
        self.playBtn.hidden = true;
        self.buttonsView.hidden = false;
        self.resumeBtn.hidden = true;
        
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
        self.resumeBtn.hidden = false;
    }
    
    @IBAction func stop(sender: AnyObject) {
        self.pausedDate = NSDate();
        if(self.todoTitleField.text == "") {
            self.confirmToggleView.toggledTime = self.recordedTime.text!;
            self.navigationController?.pushViewController(self.confirmToggleView, animated: true);
        }
        timer.invalidate();
        self.recordedTime.text = "00:00:00";
        self.pausedTimeInterval = 0;
        self.stopBtn.hidden = true;
        self.pauseBtn.hidden = true;
        self.resumeBtn.hidden = true;
        self.playBtn.hidden = false;
    }
    
    @IBAction func resume(sender: AnyObject) {
        self.resumeBtn.hidden = true;
        self.pauseBtn.hidden = false;
        self.startPlay(sender);
        
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return todoProjectPickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return todoProjectPickerDataSource[row]
    }
}
