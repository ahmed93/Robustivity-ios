//
//  ToggleViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

// Class contributors [Aya Amr, Jihan Adel]

import UIKit

class ToggleViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var toggleResumeBtnCenterX: NSLayoutConstraint!
    @IBOutlet weak var toggleStopBtnCenterX: NSLayoutConstraint!
    @IBOutlet weak var toggleStopBtn: UIButton!
    @IBOutlet weak var togglePauseBtnCenterX: NSLayoutConstraint!
    @IBOutlet weak var togglePauseBtn: UIButton!
    @IBOutlet weak var toggleResumeBtn: UIButton!
    @IBOutlet weak var togglePlayBtn: UIButton!
    @IBOutlet weak var toggledTime: UILabel!
    
    @IBOutlet weak var todoTitleField: UITextField!
    
    
    @IBOutlet weak var todoProjectTextField: UITextField!
    var timer = NSTimer();
    var startDate = NSDate();
    var pausedDate = NSDate();
    var currentTimeInterval = NSTimeInterval();
    var pausedTimeInterval = NSTimeInterval();
    
    var todoProjectsName = ["Project name", "Farmraiser", "LMS", "Innovation Portal", "Maill buddy"];
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("ToggleViewController", owner: self, options: nil)
    }
    
    /*
    ** viewDidLoad
    ** responsable for setting the up the view
    */
    
    override func viewDidLoad() {
        self.wantsUserCheckInStatus = true
        super.viewDidLoad()
        self.edgesForExtendedLayout = .Bottom
        self.title = "Toggle";
        self.navigationItem.title = "Toggle";
        
        //        self.navigationController?.navigationBar.translucent = tr; //added to calculate the distance from the top of the page after the nav bar
        
        /* Add circular shape to buttons*/
        self.togglePlayBtn.layer.cornerRadius = 0.5 * self.togglePlayBtn.bounds.size.width;
        self.togglePlayBtn.backgroundColor = Theme.greenColor();
        self.togglePauseBtn.layer.cornerRadius = 0.5 * self.togglePauseBtn.bounds.size.width;
        self.togglePauseBtn.backgroundColor = Theme.lighterBlackColor();
        self.toggleStopBtn.layer.cornerRadius = 0.5 * self.toggleStopBtn.bounds.size.width;
        self.toggleStopBtn.backgroundColor = Theme.redColor();
        self.toggleResumeBtn.layer.cornerRadius = 0.5 * self.toggleResumeBtn.bounds.size.width;
        self.toggleResumeBtn.backgroundColor = Theme.greenColor();
        
        Theme.style_5(self.toggledTime); //missing correct font and is not specified in properties
        
        self.toggledTime.text = "00:00:00";
        self.toggledTime.textColor = Theme.blackColor();
        
        /* Add indentation between text field and inout data*/
        let todoTitlePaddingView = UIView(frame: CGRectMake(0,0,14,20));
        self.todoTitleField.leftView = todoTitlePaddingView;
        self.todoTitleField.leftViewMode = UITextFieldViewMode.Always;
        
        let todoProjectPaddingView = UIView(frame: CGRectMake(0,0,14,20));
        self.todoProjectTextField.leftView = todoProjectPaddingView;
        self.todoProjectTextField.leftViewMode = UITextFieldViewMode.Always;
        
        self.todoTitleField.backgroundColor = Theme.lightGrayColor();
        self.todoTitleField.attributedPlaceholder = NSAttributedString(string:"ToDo title",
            attributes:[NSForegroundColorAttributeName: Theme.grayColor()]); //Add Placeholder with custom color
        
        self.todoProjectTextField.backgroundColor = Theme.lightGrayColor();
        self.todoProjectTextField.attributedPlaceholder = NSAttributedString(string:"Project name", attributes:[NSForegroundColorAttributeName: Theme.grayColor()]); //Add placeholder with custom color
        
        let projectPicker = UIPickerView(); //Add picker view to be used in project names
        projectPicker.dataSource = self;
        projectPicker.delegate = self;
        
        self.todoProjectTextField.inputView = projectPicker; //Assign picker to textfield
        self.toggleStopBtn.alpha = 0;
        self.togglePauseBtn.alpha = 0;
        self.toggleResumeBtn.alpha = 0;
        
    }
    
    /*
    ** toggleStartPlay
    ** The method is responsible for starting the timer
    ** inputs -> sender: AnyObject (UIButton)
    */
    
    @IBAction func toggleStartPlay(sender: AnyObject) {
        let currentDate = NSDate();
        startDate = currentDate;
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateToggledTime"), userInfo: nil, repeats: true);
        
        self.toggledTime.textColor = Theme.greenColor();
        
        UIView.animateWithDuration(0.5, animations: {
            self.togglePlayBtn.alpha = 0;
            self.toggleResumeBtn.alpha = 0;
            
            self.toggleStopBtn.alpha = 1;
            self.togglePauseBtn.alpha = 1;
            
            self.toggleStopBtnCenterX.constant = 75;
            
            self.togglePauseBtnCenterX.constant = -75;
        })
        
    }
    
    /*
    ** updateToggledTime
    ** CallBack function for NStimer 
    ** compares users's current time with saved start time and 
    ** update counter accordingly
    */
    
    func updateToggledTime() {
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
        self.toggledTime.text = timeString;
        
    }
    
    /*
    ** togglePause
    ** stop the timer and save the recorded time interval
    ** update view to reflect pause situation
    ** inputs -> sender: AnyObject (UIButton)
    */
    
    @IBAction func togglePause(sender: AnyObject) {
        self.pausedDate = NSDate();
        timer.invalidate(); //stop timer
        self.toggledTime.textColor = Theme.blackColor();
        self.pausedTimeInterval = self.currentTimeInterval;
        
        UIView.animateWithDuration(0.5, animations: {
            self.togglePauseBtn.alpha = 0; //hide button
            self.toggleResumeBtn.alpha = 1; //show button
            self.toggleResumeBtnCenterX.constant = -75;
            
        })
    }
    
    /*
    ** toggleStop
    ** stoppes the timer
    ** should submit saved time in the backed ?
    ** reset the view to initial view situation
    ** inputs -> sender: AnyObject (UIButton)
    */
    
    @IBAction func toggleStop(sender: AnyObject) {
        self.pausedDate = NSDate();
        
        timer.invalidate();
        self.toggledTime.textColor = Theme.blackColor();
        self.toggledTime.text = "00:00:00";
        self.pausedTimeInterval = 0;
        UIView.animateWithDuration(0.5, animations: {
            self.togglePlayBtn.alpha = 1;
            self.togglePauseBtn.alpha = 0;
            self.toggleResumeBtn.alpha = 0;
            self.toggleStopBtn.alpha = 0;
        })
        
    }
    
    /*
    ** toggleResume 
    ** resumes the timer
    ** inputs -> sender: AnyObject (UIButton)
    */
    
    @IBAction func toggleResume(sender: AnyObject) {
        self.toggleStartPlay(sender);
        
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
