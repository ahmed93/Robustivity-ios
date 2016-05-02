//
//  ToggleViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

// Class contributors [Aya Amr, Jihan Adel, Nouran Mamdouh]

import UIKit
import ObjectMapper
import RealmSwift


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

    let toggleHelper = ToggleHelper.sharedInstance
    let realm = try! Realm()
    let projectPicker = UIPickerView(); //Add picker view to be used in project names

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
        viewSetup()
        self.toggleHelper.currentTaskState = "intial"
        self.toggleHelper.fetchTasks({ () in
            self.toggleResumeViewSetup()
        })
//        print("DB LOCATION IS \(Realm.Configuration.defaultConfiguration.path!)" )
        
        toggleHelper.fetchProjectsList()
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pauseTimerNotification", name:"pauseTimerNotification", object: nil)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resumeTimerNotification", name:"resumeTimerNotification", object: nil)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopTimerNotification", name:"stopTimerNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateToggledTimeNotification", name:"updateToggledTimeNotification", object: nil)
        

    }
    
    func viewSetup() {
        
        self.title = "Toggle";
        self.navigationItem.title = "Toggle";
        
        self.navigationController?.navigationBar.translucent = false; //added to calculate the distance from the top of the page after the nav bar
        
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
        
        /* Add indentation between text field and input data*/
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
        self.projectPicker.dataSource = self;
        self.projectPicker.delegate = self;
        
        self.todoProjectTextField.inputView = projectPicker; //Assign picker to textfield
        self.toggleStopBtn.alpha = 0;
        self.togglePauseBtn.alpha = 0;
        self.toggleResumeBtn.alpha = 0;
        
        //Track input fields change
        self.todoTitleField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingDidEnd)
        
        self.todoProjectTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingDidEnd)

        
        //Add tab gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapGesture)
        
    }
    

    
    override func viewWillAppear(animated: Bool) {
        print("View will appear")
        self.toggleHelper.fetchTasks({ () in
            self.toggleResumeViewSetup()
        })
    }
    
    
    /*
    ** toggleStartPlay
    ** The method is responsible for starting the timer
    ** inputs -> sender: AnyObject (UIButton)
    */
    
    @IBAction func toggleStartPlay(sender: AnyObject) {
        
        createTodo()
    }

    func createTodo() {
        var requestParams = [String : AnyObject]()
        
        if self.todoTitleField.text == "" {
            requestParams["task[name]"] = "iOS Noname"
            
        }else{
            
            requestParams["task[name]"] = self.todoTitleField.text
            
        }
        
        
        if self.todoProjectTextField.text == "" {
            self.projectPicker.selectRow(0, inComponent: 0, animated: false)
            self.todoProjectTextField.text = "miscellaneous"
            requestParams["task[project_id]"] = 1
            
        }else{
            
            let projectId = self.projectPicker.selectedRowInComponent(0) + 1
            print(projectId)
            requestParams["task[project_id]"] = projectId
            
        }
        
        let url = APIRoutes.TODO_CREATE
        let urlWithToggleStart = url + "?toggl=1"
        
        API.post(urlWithToggleStart, parameters: requestParams , callback: { (success, response) in
            if(success) {
                let todo = Mapper<TaskModel>().map(response["task"])
                todo?.updateTask()
                self.toggleHelper.toggleTask = todo!
                self.toggleHelper.startDate = NSDate()
                self.toggleResumeViewSetup()
                self.toggleHelper.currentTaskState = "playing"
                self.toggleHelper.startTimer()
                
            }
            
        })
        
    }
    
    
    /*
    ** togglePause
    ** stop the timer and save the recorded time interval
    ** update view to reflect pause situation
    ** inputs -> sender: AnyObject (UIButton)
    */
    
    @IBAction func togglePause(sender: AnyObject) {
        
        self.toggleHelper.togglePauseAction({ () in
            self.togglePauseViewSetup()
        })
    }
    
//    func pauseTimerNotification() {
//        self.toggledTime.textColor = Theme.blackColor();
//        
//        UIView.animateWithDuration(0.5, animations: {
//            self.togglePauseBtn.alpha = 0; //hide button
//            self.toggleResumeBtn.alpha = 1; //show button
//            self.toggleResumeBtnCenterX.constant = -75;
//            
//        })
//        
//    }
    func togglePauseViewSetup() {
        self.toggledTime.textColor = Theme.blackColor();
        
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

        self.toggleHelper.toggleStopAction({ () in
            self.toggleStopViewSetup()
        })
        
    }
    
    //StopNotificationHandler
//    func stopTimerNotification() {
//        self.toggleStopViewSetup()
//    }
    
    //Front end setup for the action

    func toggleStopViewSetup() {
        self.toggledTime.textColor = Theme.blackColor();
        self.todoProjectTextField.text = ""
        self.todoTitleField.text = ""
        self.toggledTime.text = "00:00:00";
        self.toggleHelper.pausedTimeInterval = 0;
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

        self.toggleResumeBtn.enabled = false
        self.toggleHelper.toggleResumeAction({ () in
            self.toggleResumeViewSetup()
        })
    }
    
    /*Handle the resumeNotification*/
//    func resumeTimerNotification()->() {
//        
//        self.toggleResumeViewSetup()
//    }
    
    /*Change view setup to resume setup*/
    func toggleResumeViewSetup() {
        
        self.todoTitleField.text = self.toggleHelper.toggleTask.taskName
        print(self.toggleHelper.toggleTask.taskProjectName)
        self.todoProjectTextField.text = self.toggleHelper.toggleTask.taskProjectName
        if(self.toggleHelper.toggleTask.taskProjectName == "") {
            self.todoProjectTextField.text = "miscellaneous"
        }
        self.projectPicker.selectRow(self.toggleHelper.toggleTask.taskProjectId - 1, inComponent: 0, animated: false)
        self.toggledTime.textColor = Theme.greenColor();
        self.toggleResumeBtn.enabled = true
        UIView.animateWithDuration(0.5, animations: {
            self.togglePlayBtn.alpha = 0;
            self.toggleResumeBtn.alpha = 0;
            
            self.toggleStopBtn.alpha = 1;
            self.togglePauseBtn.alpha = 1;
            
            self.toggleStopBtnCenterX.constant = 75;
            
            self.togglePauseBtnCenterX.constant = -75;
        })
    }
    
    func textFieldDidChange(textField: UITextField) {
        if((self.toggleHelper.currentTaskState == "playing" ||  self.toggleHelper.currentTaskState == "paused") && (self.todoTitleField.text != self.toggleHelper.toggleTask.taskName || self.todoProjectTextField.text != self.toggleHelper.toggleTask.taskProjectName)) {
            //Send update request
            
            var requestParams = [String : AnyObject]()
            
            requestParams["task[name]"] = self.todoTitleField.text
            
            if self.todoProjectTextField.text != "" {
                let projectId = self.projectPicker.selectedRowInComponent(0) + 1
                
                requestParams["task[project_id]"] = projectId
                
            }
            
            let url = APIRoutes.TASKS_INDEX
            let urlWithTaskId = url + String(self.toggleHelper.toggleTask.taskId)
            
            API.put(urlWithTaskId, parameters: requestParams , callback: { (success, response) in
                if(success) {
                    
                    //Pending API modification to avoid empty response
                    let todo = Mapper<TaskModel>().map(response)
                    todo?.updateTask()
                    self.toggleHelper.toggleTask = todo!
                    
                }
                
            })
        }

    }
    
    //Gesture handler
    func dismissKeyboard() {
        self.todoTitleField.resignFirstResponder()
        self.todoProjectTextField.resignFirstResponder()
        
    }
    
    func updateToggledTimeNotification() {
        self.toggledTime.text = self.toggleHelper.toggledTime
    }

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.toggleHelper.todoProjectsName.count;
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.todoProjectTextField.text = self.toggleHelper.todoProjectsName[row];
        self.todoProjectTextField.resignFirstResponder();
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.toggleHelper.todoProjectsName[row]
    }
}
