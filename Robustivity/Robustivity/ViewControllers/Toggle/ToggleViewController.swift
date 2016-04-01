//
//  ToggleViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ToggleViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var resumeBtnCenterX: NSLayoutConstraint!
    @IBOutlet weak var stopBtnCenterX: NSLayoutConstraint!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var pauseBtnCenterX: NSLayoutConstraint!
    @IBOutlet weak var pauseBtn: UIButton!
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
        super.viewDidLoad()
        self.title = "Toggle";
        self.navigationItem.title = "Toggle";

        self.navigationController?.navigationBar.translucent = false; //added to calculate the distance from the top of the page after the nav bar
        
        /* Add circular shape to buttons*/
        self.playBtn.layer.cornerRadius = 0.5 * self.playBtn.bounds.size.width;
        self.playBtn.backgroundColor = Theme.greenColor();
        self.pauseBtn.layer.cornerRadius = 0.5 * self.pauseBtn.bounds.size.width;
        self.pauseBtn.backgroundColor = Theme.lighterBlackColor();
        self.stopBtn.layer.cornerRadius = 0.5 * self.stopBtn.bounds.size.width;
        self.stopBtn.backgroundColor = Theme.redColor();
        self.resumeBtn.layer.cornerRadius = 0.5 * self.resumeBtn.bounds.size.width;
        self.resumeBtn.backgroundColor = Theme.greenColor();

        Theme.style_5(self.recordedTime); //missing correct font and is not specified in properties

        self.recordedTime.text = "00:00:00";
        self.recordedTime.textColor = Theme.blackColor();
        
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
        self.stopBtn.alpha = 0;
        self.pauseBtn.alpha = 0;
        self.resumeBtn.alpha = 0;

    }
    
    /*
    ** startPlay 
    ** The method is responsible for starting the timer
    */
    
    @IBAction func startPlay(sender: AnyObject) {
        let currentDate = NSDate();
        startDate = currentDate;
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true);
        
        self.recordedTime.textColor = Theme.greenColor();
        
        UIView.animateWithDuration(0.5, animations: {
            self.playBtn.alpha = 0;
            self.resumeBtn.alpha = 0;
            
            self.stopBtn.alpha = 1;
            self.pauseBtn.alpha = 1;

            self.stopBtnCenterX.constant = 75;

            self.pauseBtnCenterX.constant = -75;
        })
        
    }
    
    /*
    ** updateCounter
    ** CallBack function for NStimer 
    ** compares users's current time with saved start time and 
    ** update counter accordingly
    */
    
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
    
    /*
    ** pause
    ** stop the timer and save the recorded time interval
    ** update view to reflect pause situation
    */
    
    @IBAction func pause(sender: AnyObject) {
        self.pausedDate = NSDate();
        timer.invalidate(); //stop timer
        self.recordedTime.textColor = Theme.blackColor();
        self.pausedTimeInterval = self.currentTimeInterval;
        
        UIView.animateWithDuration(0.5, animations: {
            self.pauseBtn.alpha = 0; //hide button
            self.resumeBtn.alpha = 1; //show button
            self.resumeBtnCenterX.constant = -75;
            
        })
    }
    
    /*
    ** stop 
    ** stoppes the timer
    ** should submit saved time in the backed ?
    ** reset the view to initial view situation
    */
    
    @IBAction func stop(sender: AnyObject) {
        self.pausedDate = NSDate();

        timer.invalidate();
        self.recordedTime.textColor = Theme.blackColor();
        self.recordedTime.text = "00:00:00";
        self.pausedTimeInterval = 0;
        UIView.animateWithDuration(0.5, animations: {
            self.playBtn.alpha = 1;
            self.pauseBtn.alpha = 0;
            self.resumeBtn.alpha = 0;
            self.stopBtn.alpha = 0;
        })
        
    }
    
    /*
    ** resume 
    ** resumes the timer
    */
    
    @IBAction func resume(sender: AnyObject) {
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
