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
    
    
    let realm = try! Realm()
    let projectPicker = UIPickerView(); //Add picker view to be used in project names
    
    var todoProjectsName = [String]()
    
    // Assuty add weak to toggledTask
    weak var toggleTask:TaskModel?
    let toggleManager = ToggleManager.sharedInstance
    
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
        self.fetchProjectsList()
        viewSetup()
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
        //
        self.todoProjectTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingDidEnd)
        
        
        //Add tab gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        print("View will appear")
        toggleManager.delegate = self
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        toggleManager.delegate = nil
    }
    
    func fetchProjectsList() {
        API.get(APIRoutes.PROJECTS_INDEX, callback: { (success, response) in
            if(success){
                self.todoProjectsName = [String]()
                //map the json object to the model and save them
                let projects = Mapper<Project>().mapArray(response)
                for project in projects! {
                    self.todoProjectsName.append(project.projectName)
                    project.save()
                }
                
            }
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
                let playingTasks = self.realm.objects(TaskModel).filter("taskStatus = 'in_progress'")
                for playingTask in playingTasks {
                    try! self.realm.write {
                        playingTask.taskStatus = "paused"
                    }
                }
                let todo = Mapper<TaskModel>().map(response["task"])
                todo?.updateTask()
                self.toggleManager.playNewTask(todo!)
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
        toggleManager.pauseCurrentTask()
    }
    
    func togglePauseViewSetup() {
        self.todoTitleField.text = self.toggleTask!.taskName
        self.todoProjectTextField.text = self.toggleTask!.taskProjectName
        if(self.toggleTask!.taskProjectName == "") {
            self.todoProjectTextField.text = "miscellaneous"
        }
        self.projectPicker.selectRow(self.toggleTask!.taskProjectId - 1, inComponent: 0, animated: false)
        
        self.toggledTime.textColor = Theme.blackColor();
        
        UIView.animateWithDuration(0.5, animations: {
            
            self.togglePlayBtn.alpha = 0;
            
            self.toggleStopBtn.alpha = 1;
            
            self.toggleStopBtnCenterX.constant = 75;
            
            self.togglePauseBtnCenterX.constant = -75;
            
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
        toggleManager.stopCurrentTask()
    }
    
    //Front end setup for the action
    
    func toggleStopViewSetup() {
        self.toggledTime.textColor = Theme.blackColor();
        self.todoProjectTextField.text = ""
        self.todoTitleField.text = ""
        self.toggledTime.text = "00:00:00";
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
        toggleManager.resumeCurrentTask()
    }
    
    /*Change view setup to resume setup*/
    func toggleResumeViewSetup() {
        
        self.todoTitleField.text = self.toggleTask!.taskName
        self.todoProjectTextField.text = self.toggleTask!.taskProjectName
        if(self.toggleTask!.taskProjectName == "") {
            self.todoProjectTextField.text = "miscellaneous"
        }
        self.projectPicker.selectRow(self.toggleTask!.taskProjectId - 1, inComponent: 0, animated: false)
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
        if( (self.toggleTask != nil)&&(self.todoTitleField.text != self.toggleTask!.taskName || self.todoProjectTextField.text != self.toggleTask!.taskProjectName)) {
            //Send update request
            
            var requestParams = [String : AnyObject]()
            
            requestParams["task[name]"] = self.todoTitleField.text
            
            if self.todoProjectTextField.text != "" {
                let projectId = self.projectPicker.selectedRowInComponent(0) + 1
                
                requestParams["task[project_id]"] = projectId
                
            }
            
            let url = APIRoutes.TASKS_INDEX
            let urlWithTaskId = url + String(self.toggleTask!.taskId)
            
            API.put(urlWithTaskId, parameters: requestParams , callback: { (success, response) in
                if(success) {
                    
                    //Pending API modification to avoid empty response
                    let todo = Mapper<TaskModel>().map(response)
                    todo?.updateTask()
                    self.toggleTask = todo!
                    
                }
                
            })
        }
        
    }
    
    //Gesture handler
    func dismissKeyboard() {
        self.todoTitleField.resignFirstResponder()
        self.todoProjectTextField.resignFirstResponder()
        
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


extension ToggleViewController : ToggleManagerDelegate {
    // Assuty
    // ToggleTimer Delegate functions
    func prepareViewForTask(task: TaskModel){
        switch task.taskStatus {
        case TaskStatus.InProgress.rawValue:
            self.toggleResumeViewSetup()
        case TaskStatus.Paused.rawValue:
            self.togglePauseViewSetup()
        case TaskStatus.Closed.rawValue:
            self.toggleStopViewSetup()
        default:
            print("Got Status : \(task.taskStatus)")
        }
    }
    
    func toggleManager(toggleManager: ToggleManager, didUpdateTimer value: String) {
        toggledTime.text = value
    }
    
    func toggleManager(toggleManager: ToggleManager, hasTask task: TaskModel?, toggledTime: String?) {
        guard let task = task else {
            self.toggleStopViewSetup()
            self.toggledTime.text = "00:00:00"
            return
        }

        self.toggleTask = task
        prepareViewForTask(task)
        self.toggledTime.text = toggledTime
    }
    
    func toggleManager(toggleManager: ToggleManager, didChangeToggledTask task: TaskModel, toggledTime: String) {
        self.toggleTask = task
        prepareViewForTask(task)
    }
    
    func toggleManager(toggleManager: ToggleManager, didPauseTimer time: String, forTask task: TaskModel) {
        self.toggleTask = task
        self.togglePauseViewSetup()
        toggledTime.text = time
    }
    
    func toggleManager(toggleManager: ToggleManager, didStopTimer time: String, forTask task: TaskModel) {
        self.toggleStopViewSetup()
        toggledTime.text = "00:00:00"
    }
    
}