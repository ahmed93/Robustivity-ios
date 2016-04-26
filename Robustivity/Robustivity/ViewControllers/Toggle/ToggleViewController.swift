//
//  ToggleViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

// Class contributors [Aya Amr, Jihan Adel]

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
    var timer = NSTimer();
    var startDate = NSDate();
//    var pausedDate = NSDate();
    var currentTimeInterval = NSTimeInterval();
    var pausedTimeInterval = NSTimeInterval();

    var toggleTask:TaskModel = TaskModel()
    
    var todoProjectsName = [String]();
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
        super.viewDidLoad()
        viewSetup()
        print("DB LOCATION IS \(Realm.Configuration.defaultConfiguration.path!)" )
        /*********START BACKEND TEST **********************/
        
       /*To be done save a paused task , if no playing task display the paused one , if no playing and no saved pause display last paused task if no display empty and allow new task creation*/
        
        fetchProjectsList()
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
        
//        let projectPicker = UIPickerView(); //Add picker view to be used in project names
        self.projectPicker.dataSource = self;
        self.projectPicker.delegate = self;
        
        self.todoProjectTextField.inputView = projectPicker; //Assign picker to textfield
        self.toggleStopBtn.alpha = 0;
        self.togglePauseBtn.alpha = 0;
        self.toggleResumeBtn.alpha = 0;
        
    }
    

    
    override func viewWillAppear(animated: Bool) {
        print("View will appear")
//        fetchProjectsList()
//        fetchTasks()
        
//        if setTaskToCurrentPlayingTask() {
//            self.todoTitleField.text = self.toggleTask.taskName
//            self.setTodoProjectName(self.toggleTask)
//            getToggledTime(self.toggleTask)
//            toggleResumeAction()
//        
//            
//        }

    }
    
    /*Add all timelogs intervals for a specfic task to be able to get previous toggled time*/
    func getToggledTime(task: TaskModel) {
        let filterString = "timelogTaskId == " + String(task.taskId)

        let timelog = self.realm.objects(Timelog).filter(filterString).first

        if(timelog != nil) {
            let entryFilterString = "timelogId == " + String(timelog!.timelogId)
            let timeIntervals = self.realm.objects(TimeEntry).filter(entryFilterString)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZ"
            var totalTimeInterval = NSTimeInterval();
            
            for timeInterval in timeIntervals {
                let entryStartDate = dateFormatter.dateFromString(timeInterval.timeEntryStartedAt)!
                let entryEndDate = dateFormatter.dateFromString(timeInterval.timeEntryEndedAt)
                let timeDiff = entryEndDate!.timeIntervalSinceDate(entryStartDate);

                totalTimeInterval += timeDiff
                

            }
//
            print("totla time interval")
            print(totalTimeInterval)
            
//            let previousToggledDuration = NSNumber(integer: (timelog?.timelogDuration)!)
            self.pausedTimeInterval = totalTimeInterval //NSTimeInterval(previousToggledDuration.doubleValue)

        }

    }
    
    func setTodoProjectName(task: TaskModel) {
        let filterString = "projectId == " + String(task.taskProjectId)
        let project = self.realm.objects(Project).filter(filterString).first!
        
        self.todoProjectTextField.text = project.projectName
        
    }
    
    
    func fetchTasks() {
        API.get(APIRoutes.TASKS_INDEX+"?page=1&per_page=10000000000", callback: { (success, response) in
            if(success){
                    
                //map the json object to the model and save them
                let tasks = Mapper<TaskModel>().mapArray(response)
                for task in tasks! {
                    self.updateTask(task)
                    self.fetchTaskTimelogs(task)
                }
                    
            }
        })
    }
    
    
    /*Add or update task*/
    func updateTask(task: TaskModel) {
        try! self.realm.write {
            self.realm.add(task, update: true)
        }
    }
    
    
    func fetchProjectsList() {
        API.get(APIRoutes.PROJECTS_INDEX, callback: { (success, response) in
            if(success){
                self.todoProjectsName = [String]()
                //map the json object to the model and save them
                let projects = Mapper<Project>().mapArray(response)
                for project in projects! {
                    self.todoProjectsName.append(project.projectName)
                    self.updateProject(project)
                }
                
            }
        })
        
    }
    
    //save new and update project on disk using realm
    func updateProject(project: Project) {
        try! self.realm.write {
            self.realm.add(project, update: true)
        }
    }

    
    func fetchTaskTimelogs(task: TaskModel) {
        
        let url = APIRoutes.TASKS_TIMELOG
        let urlWithTaskId = (url as NSString).stringByReplacingOccurrencesOfString("{task_id}", withString: String(task.taskId))
        
        API.get(urlWithTaskId, callback: { (success, response) in
            if(success){
                
                let timelog = Mapper<Timelog>().map(response["time_log"])
                self.updateTimelog(timelog!)
                let timeEntries = Mapper<TimeEntry>().mapArray(response["time_entries"])
                for timeEntry in timeEntries! {
                    self.updateTimeEntry(timeEntry)
                }
                
            }
        })

    }
    
    /* update time entry (Object) if already exists or save new timeEntry if doesn't exist 
    on disk using realm */
    func updateTimeEntry(timeEntry: TimeEntry) {
        try! self.realm.write {
            self.realm.add(timeEntry, update: true)
        }

    }
    
    //save new Time log or update existing one on disk using realm
    func updateTimelog(timelog: Timelog) {
        try! self.realm.write {
            self.realm.add(timelog, update: true)
        }

    }
    
    func setTaskToCurrentPlayingTask()->Bool {
        
        let timelog = self.realm.objects(Timelog).filter("timelogStatus == 'playing'").first
        
        if(timelog != nil) {
            let filterString = "taskId == " + String(timelog!.timelogTaskId)
            self.toggleTask = realm.objects(TaskModel).filter(filterString).first!
            return true
        }

        return false
    }
    



    
    /*
    ** toggleStartPlay
    ** The method is responsible for starting the timer
    ** inputs -> sender: AnyObject (UIButton)
    */
    
    @IBAction func toggleStartPlay(sender: AnyObject) {
        
        createTodo()
        
//        let currentDate = NSDate();
//        startDate = currentDate;
//        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateToggledTime"), userInfo: nil, repeats: true);
//        
//        
//        self.toggledTime.textColor = Theme.greenColor();
//        
//        UIView.animateWithDuration(0.5, animations: {
//            self.togglePlayBtn.alpha = 0;
//            self.toggleResumeBtn.alpha = 0;
//            
//            self.toggleStopBtn.alpha = 1;
//            self.togglePauseBtn.alpha = 1;
//
//            self.toggleStopBtnCenterX.constant = 75;
//
//            self.togglePauseBtnCenterX.constant = -75;
//        })
        
    }
    
    func toggleStartPlayAction() {
        let currentDate = NSDate();
        startDate = currentDate;
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateToggledTime"), userInfo: nil, repeats: true);
        
        
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
    
//    func getProjectId (projectName: String) -> Int {
//        let filterString = "projectName == " + String(projectName)
//        let project = self.realm.objects(Project).filter("projectName == ").first!
//        
//        print("condition passed")
////
////        return project.projectId
//        return 1
//        
//    }
    func createTodo() {
        var requestParams = [String : AnyObject]()
        
        requestParams["task[name]"] = self.todoTitleField.text
        
        if self.todoProjectTextField.text != "" {
            let projectId = self.projectPicker.selectedRowInComponent(0) + 1
            
            requestParams["task[project_id]"] = projectId
            
        }
        
        let url = APIRoutes.TODO_CREATE
        let urlWithToggleStart = url + "?toggl=1"
        
        API.post(urlWithToggleStart, parameters: requestParams , callback: { (success, response) in
            if(success) {
//                self.fetchTasks()
                let todo = Mapper<TaskModel>().map(response["task"])
                
                self.updateTask(todo!)
                self.toggleTask = todo!
                self.toggleResumeAction()

//                self.fetchTaskTimelogs(todo!)
                
//                if self.setTaskToCurrentPlayingTask() {
//                    self.todoTitleField.text = self.toggleTask.taskName
//                    self.setTodoProjectName(self.toggleTask)
//                    self.getToggledTime(self.toggleTask)
//                    self.toggleResumeAction()
//                    
//                    
//                }
                
            }
            
        })

        
    }
    
    /*
    ** updateToggledTime
    ** CallBack function for NStimer 
    ** compares users's current time with saved start time and 
    ** update counter accordingly
    */
    
     @objc func updateToggledTime() {
        // Create date from the elapsed time
        let currentDate = NSDate();
        
        var timeInterval = currentDate.timeIntervalSinceDate(self.startDate);
        print(pausedTimeInterval)
        print(timeInterval)
        timeInterval += pausedTimeInterval;

//        let timerDate = NSDate(timeIntervalSince1970: timeInterval);
//        print(timerDate)
         // Create a date formatter
//        let dateFormatter = NSDateFormatter();
//        dateFormatter.dateFormat = "HH:mm:ss";
//        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0);
//        let timeString = dateFormatter.stringFromDate(timerDate);
        self.currentTimeInterval = timeInterval;
//        self.toggledTime.text = timeString;
        self.toggledTime.text = stringFromTimeInterval(timeInterval)
        
    }
    
    /*
    ** togglePause
    ** stop the timer and save the recorded time interval
    ** update view to reflect pause situation
    ** inputs -> sender: AnyObject (UIButton)
    */
    
    @IBAction func togglePause(sender: AnyObject) {
        
        let url = APIRoutes.TASK_TIMELOG_PAUSE
        let urlWithTaskId = (url as NSString).stringByReplacingOccurrencesOfString("{task_id}", withString: String(self.toggleTask.taskId))

        let requestParams : [String: AnyObject] = ["task": self.toggleTask] //these params is not needed

        API.put(urlWithTaskId, parameters: requestParams, callback: { (success, response) in
            if(success) {
                self.togglePauseAction()
                //MAKE SURE THE TIMER IS INVALIDATED
                self.timer.invalidate(); //stop timer
//                self.pausedTimeInterval = (response["total_logged_time"] as? NSTimeInterval)!
                self.fetchTaskTimelogs(self.toggleTask) //get updated log


            }
            
        })

    }
    func togglePauseAction() {
        self.timer.invalidate(); //stop timer
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
        toggleStopApi()
    }
    
    //Perform Api request
    func toggleStopApi() {
        let url = APIRoutes.TASK_TIMELOG_STOP
        let urlWithTaskId = (url as NSString).stringByReplacingOccurrencesOfString("{task_id}", withString: String(self.toggleTask.taskId))
        
        let requestParams : [String: AnyObject] = ["task": self.toggleTask] //these params is not needed
        
        API.put(urlWithTaskId, parameters: requestParams, callback: { (success, response) in
            if(success) {
                
                self.toggleStopAction()
//                self.fetchTaskTimelogs(self.toggleTask) //get updated log


            }
            
        })
    }
    
    //Front end setup for the action
    func toggleStopAction() {
        
        self.timer.invalidate();
        self.toggledTime.textColor = Theme.blackColor();
//        self.toggleTask = TaskModel()
        self.todoProjectTextField.text = ""
        self.todoTitleField.text = ""
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
        
        let url = APIRoutes.TASK_TIMELOG_RESUME
        let urlWithTaskId = (url as NSString).stringByReplacingOccurrencesOfString("{task_id}", withString: String(self.toggleTask.taskId))
        
        let requestParams : [String: AnyObject] = ["task": self.toggleTask] //these params is not needed
        
        API.post(urlWithTaskId, parameters: requestParams, callback: { (success, response) in
            if(success) {
                
                self.fetchTaskTimelogs(self.toggleTask) //get updated log

                /******Call those 2methods in pair ******/
                self.getToggledTime(self.toggleTask)
                /*
                let filterString = "timelogTaskId == " + String(self.toggleTask.taskId)
                
                let timelog = self.realm.objects(Timelog).filter(filterString).first
                    
                let previousToggledDuration = NSNumber(integer: (timelog?.timelogDuration)!)
                self.pausedTimeInterval = NSTimeInterval(previousToggledDuration.doubleValue)
*/
                self.toggleResumeAction()
                /******END******/
                
            }
            
        })
        
        
    }
    
    func toggleResumeAction() {
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
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
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
