//
//  CreateTaskViewController.swift
//  Robustivity
//
//  Created by Mohamed Bahgat Elrakaiby on 3/27/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import JLToast

class CreateTaskViewController: BaseViewController, UITextViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var adapter:CreateTaskAdapter!
    var doneButton:UIBarButtonItem!
    var isTaskObject: Bool!
    var project_id:Int!
    var user_id:Int!
    var creator_id:Int!
    var isTaskNameValid:Bool!
    var isTaskDueDateValid:Bool!
    var isTaskDescriptionValid:Bool!
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
            
        self.title = "Task info";
        self.navigationItem.title = "Task info";
        
        //Done button on right
        
        doneButton = UIBarButtonItem();
        doneButton.title = "Done"
        doneButton.target = self
        doneButton.enabled = false
        doneButton.action = NSSelectorFromString("doneButtonPress");
        self.navigationItem.rightBarButtonItem = doneButton;
        
        self.isTaskNameValid = false
        self.isTaskDueDateValid = false
        self.isTaskDescriptionValid = false
        
        adapter = CreateTaskAdapter(viewController: self, tableView: tableView!, registerMultipleNibsAndIdenfifers: ["TextViewTaskViewCell":"textViewCell", "LabelTextTaskViewCell":"labelCell"]);
        
    }
    
    
    //MARK: - TextView delegate methods
    
    var defaultTextViewsValues = Dictionary<UITextView,String>();
    var TextViewDistanceTobottomNormalCaseValues = Dictionary<UITextView,CGFloat>();
    var TextViewDistanceTobottomOnWritingValues  = Dictionary<UITextView,CGFloat>();
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        let textViewDefaultText = defaultTextViewsValues[textView]
        let isTaskName = textViewDefaultText!.containsString("Task Name") ? true : false
        
        if(isTaskName){
            
            (self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! TextViewTaskViewCell).textViewDistanceToBottom.constant = CGFloat(TextViewDistanceTobottomOnWritingValues[textView]!)
        }
        else{
            
            (self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! TextViewTaskViewCell).textViewDistanceToBottom.constant = CGFloat(TextViewDistanceTobottomOnWritingValues[textView]!)
        }
        
        if(textView.text == defaultTextViewsValues[textView]){
            
            textView.textColor = Theme.blackColor()
            textView.text = "";
        }
        
        return true;
    }
    
    func textViewDidChange(textView: UITextView) {
        
        let textViewDefaultText = defaultTextViewsValues[textView]
        let isTaskName = textViewDefaultText!.containsString("Task Name") ? true : false
        
        if(textView.text.characters.count > 0){
            
            if(isTaskName){
                
                isTaskNameValid = true
            }
            else{
                
                isTaskDescriptionValid = true
            }
        }
        else{
            
            if(isTaskName){
                
                isTaskNameValid = false
            }
            else{
                
                isTaskDescriptionValid = false
            }
        }
        
        self.validate()
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        
        let textViewDefaultText = defaultTextViewsValues[textView]
        let isTaskName = textViewDefaultText!.containsString("Task Name") ? true : false
        
        if(isTaskName){
            
            (self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! TextViewTaskViewCell).textViewDistanceToBottom.constant = CGFloat(TextViewDistanceTobottomNormalCaseValues[textView]!)
        }
        else{
            
            (self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! TextViewTaskViewCell).textViewDistanceToBottom.constant = CGFloat(TextViewDistanceTobottomNormalCaseValues[textView]!)
        }
        
        if(textView.text == defaultTextViewsValues[textView]){
            
            textView.textColor = Theme.blackColor()
            textView.text = "";
        }
        
        
        if(textView.text.isEmpty){
            
            textView.textColor = Theme.getColor(Color(rawValue: 0x828282)!)
            textView.text = textViewDefaultText
            
            var errorMessage = ""
            
            if(isTaskName){
                
                isTaskNameValid = false
                
                errorMessage = "Task name required"
            }
            else{
                
                isTaskDescriptionValid = false
                
                errorMessage = "Task description required"
            }
            
            let box = JLToast.makeText(errorMessage, duration: JLToastDelay.ShortDelay)
            box.view.backgroundView.backgroundColor = UIColor(hexValue: 0x828282)
            box.show()
        }
        
        self.validate()
        
        return true;
    }
    
    
    //MARK: - TextField delegate methods
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text;
        
        if(text?.characters.count >= 10 && string.characters.count == 1){
            return false;
        }
        
        let letters = NSCharacterSet.letterCharacterSet();
        let specialC = NSCharacterSet.alphanumericCharacterSet().invertedSet;
        let numberL = string.rangeOfCharacterFromSet(letters)?.count;
        let number = string.rangeOfCharacterFromSet(specialC)?.count;
        
        if(number >= 1 || numberL >= 1){
            return false;
        }
        
        let numberOfGroups = (text?.componentsSeparatedByString(".").count)! - 1;
        
        if(!(text?.isEmpty)! && !(string.isEmpty) && ((text?.characters.count)! - numberOfGroups) % 2 == 0){
            
            if(numberOfGroups < 2){
                textField.text = text! + ".";
            }
        }
        
        return true;
    }
    
    func textFieldDidChange(textField: UITextField) {
        
        self.validateDate()
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        self.validateDate()
        
        if(!isTaskDueDateValid){
            
            let errorMessage = "Invalid or missing due date"
            
            let box = JLToast.makeText(errorMessage, duration: JLToastDelay.ShortDelay)
            box.view.backgroundView.backgroundColor = UIColor(hexValue: 0x828282)
            box.show()
        }
        
        self.validate()
        
        return true

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.validateDate()
        
        return true
    }
    
    //MARK: - Button action
    
    func doneButtonPress(){
        
        if(isTaskNameValid && isTaskDueDateValid && isTaskDescriptionValid){
            
            let taskName = (self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! TextViewTaskViewCell).textView.text!
            
            let taskDueDateString = (self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! LabelTextTaskViewCell).textField.text!
            
            let dateFormatter = NSDateFormatter()
            
            dateFormatter.dateFormat = "dd.MM.yyyy"
            
            let taskDueDate = try! dateFormatter.dateFromString(taskDueDateString)
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let taskDueDateStringValue = dateFormatter.stringFromDate(taskDueDate!)
            let estimatedTime = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: NSDate(), toDate: taskDueDate!, options: NSCalendarOptions.MatchFirst).day
            
            let taskDesciption = (self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! TextViewTaskViewCell).textView.text!
            
            if(isTaskObject.boolValue){
                
                let task  = ["task[name]" : taskName, "task[description]" : taskDesciption, "task[status]" : "newly_created", "task[start_date]" : taskDueDateStringValue, "task[estimated_time]" : estimatedTime, "task[user_id]" : user_id, "task[creator_id]" : creator_id, "task[project_id]" : project_id]
                
                API.post(APIRoutes.TASKS_CREATE, parameters: task as! [String : AnyObject], callback:{
                    (success, response) in
                    
                    if(success){
                        
                        self.dismissViewControllerAnimated(true, completion: nil);
                    }
                    else{
                        
                        let error =  String(response.message)
                        
                        let box = JLToast.makeText(error, duration: JLToastDelay.LongDelay)
                        box.view.backgroundView.backgroundColor = UIColor(hexValue: 0x828282)
                        box.show()
                    }
                })
            }
            else{
                
                let todo = ["task[name]" : taskName, "task[description]" : taskDesciption, "task[start_date]" : taskDueDateStringValue, "task[project_id]" : project_id, "task[creator_id]" : creator_id]
                
                API.post(APIRoutes.TODOS_CREATE, parameters: todo as! [String : AnyObject], callback:{
                    (success, response) in
                    
                    if(success){
                        
                        self.dismissViewControllerAnimated(true, completion: nil);
                        
                    }
                    else{
                        
                        let error =  String(response.message)
                        
                        let box = JLToast.makeText(error, duration: JLToastDelay.LongDelay)
                        box.view.backgroundView.backgroundColor = UIColor(hexValue: 0x828282)
                        box.show()
                    }
                })
                
            }
        }
    }
    
    func validate(){
        
        if(isTaskNameValid && isTaskDueDateValid && isTaskDescriptionValid){
            
            self.doneButton.enabled = true
        }
        else{
            
            self.doneButton.enabled = false
        }
    }
    
    func validateDate(){
        let taskDueDateString = (self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! LabelTextTaskViewCell).textField.text!
        
        isTaskDueDateValid = !(taskDueDateString.isEmpty) && (taskDueDateString.characters.count == 10)
        
        var taskDueDate:NSDate!
        
        if(isTaskDueDateValid.boolValue){
            
            let dateFormatter = NSDateFormatter()
            
            dateFormatter.dateFormat = "dd.MM.yyyy"
            
            taskDueDate = try! dateFormatter.dateFromString(taskDueDateString)
            
            isTaskDueDateValid = isTaskDueDateValid && (taskDueDate != nil) && (taskDueDate.laterDate(NSDate(timeIntervalSince1970: 30)).isEqualToDate(taskDueDate))
        }
        
        self.validate()
    }


}
