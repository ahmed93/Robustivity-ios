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
    
  
    @IBOutlet weak var todoProjectTextField: UITextField!
    var timer = NSTimer();
    var startDate = NSDate();
    var pausedDate = NSDate();
    var currentTimeInterval = NSTimeInterval();
    var pausedTimeInterval = NSTimeInterval();
    
    var todoProjectPickerDataSource = ["Project name", "Farmraiser", "LMS", "Innovation Portal", "Maill buddy"];
    var todoProjectsName = ["Project name", "Farmraiser", "LMS", "Innovation Portal", "Maill buddy"];

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("ToggleViewController", owner: self, options: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Toggle";
        self.navigationItem.title = "Toggle";
        
        self.edgesForExtendedLayout = .None; //added to calculate the distance from tthe top of the page after the nav bar

        
        self.playBtn.layer.cornerRadius = 0.5 * self.playBtn.bounds.size.width;
        self.playBtn.backgroundColor = Theme.greenColor();
        self.pauseBtn.layer.cornerRadius = 0.5 * self.pauseBtn.bounds.size.width;
        self.pauseBtn.backgroundColor = Theme.lighterBlackColor();
        self.stopBtn.layer.cornerRadius = 0.5 * self.stopBtn.bounds.size.width;
        self.stopBtn.backgroundColor = Theme.redColor();
        self.resumeBtn.layer.cornerRadius = 0.5 * self.resumeBtn.bounds.size.width;
        self.resumeBtn.backgroundColor = Theme.greenColor();

        self.buttonsView.hidden = true;
        Theme.style_5(self.recordedTime);

        self.recordedTime.text = "00:00:00";
        
        self.todoTitleField.backgroundColor = Theme.lightGrayColor();
        self.todoTitleField.placeholder = "ToDo title"
        
        self.todoProjectTextField.backgroundColor = Theme.lightGrayColor();
        self.todoProjectTextField.placeholder = "Project name";


        let projectPicker = UIPickerView();
        projectPicker.dataSource = self;
        projectPicker.delegate = self;
        
        self.todoProjectTextField.inputView = projectPicker;
        self.stopBtn.alpha = 0;

    }
    
    @IBAction func startPlay(sender: AnyObject) {
        let currentDate = NSDate();
        startDate = currentDate;
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true);
        
        self.recordedTime.textColor = Theme.greenColor();
        
//        self.playBtn.hidden = true;
//        self.stopBtn.hidden = false
        self.playBtn.hidden = true;

        UIView.animateWithDuration(4, animations: {
            self.stopBtn.alpha = 1
        })
//        self.stopBtn.alpha = 1
        self.buttonsView.hidden = false;
        self.pauseBtn.hidden = false;
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

        timer.invalidate();
        self.recordedTime.textColor = Theme.blackColor();
        self.recordedTime.text = "00:00:00";
        self.pausedTimeInterval = 0;
        self.buttonsView.hidden = true;
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
        return self.todoProjectsName.count;
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.todoProjectTextField.text = self.todoProjectsName[row];
        self.todoProjectTextField.resignFirstResponder();
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.todoProjectsName[row]
    }
}
