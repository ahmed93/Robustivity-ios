//
//  ToggleHelper.swift
//  Robustivity
//
//  Created by Aya Amr on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

let toggleNotificationKey = "com.robustivity.toggleNotificationKey"

class ToggleHelper {
    class var sharedInstance: ToggleHelper {
        struct Static {
            static var instance: ToggleHelper?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ToggleHelper()
        }
        
        return Static.instance!
    }
    
    var todoProjectsName = [String]()
    var timer = NSTimer();
    var startDate = NSDate();
    var apiStartDate = NSDate();
    var currentTimeInterval = NSTimeInterval();
    var pausedTimeInterval = NSTimeInterval();
    var currentTaskState = "intial"
    var toggleTask:TaskModel = TaskModel()
    let realm = try! Realm()
    var toggledTime = "00:00:00"
    
    var timerDelegate: ToggleTimerDelegate? // Assuty
    var toggleViewDelegate: ToggleTimerDelegate? //Aya
    var taskInfoViewDelegate: ToggleTimerDelegate?
    var feedViewDelegate: ToggleTimerDelegate?

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
    
    func fetchTasks(onNewRunningTaskExists:()->()) {
        API.get(APIRoutes.TASKS_INDEX, callback: { (success, response) in
            if(success){
                
                //map the json object to the model and save them
                let tasks = Mapper<TaskModel>().mapArray(response)
                for task in tasks! {
                    task.updateTask()
                    if ( (task.taskStatus == "in_progress") ) {
                        self.timer.invalidate()
                        self.toggleTask = task
                        self.currentTaskState = "playing"
                        let interval:NSTimeInterval = Double(task.taskDuration)
                        self.pausedTimeInterval = interval
                        self.startDate = task.taskUpdatedAt!
                        onNewRunningTaskExists()
                        self.startTimer()
                    }
                    
                }
                
            }
            
        })
    }
    
    func startTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateToggledTime"), userInfo: nil, repeats: true);
//        self.delegate?.toggleTimer!(self.timer, didStartTimer: self.toggledTime) // Aya
        self.toggleViewDelegate?.toggleTimer!(self.timer, didStartTimer: self.toggledTime) // Aya
        self.taskInfoViewDelegate?.toggleTimer!(self.timer, didStartTimer: self.toggledTime)
        self.feedViewDelegate?.toggleTimer!(self.timer, didStartTimer: self.toggledTime)


    }
    
    func togglePauseAction(onSuccess: ()->()) {
        if(self.toggleTask.taskId == 0) {
            return
        }
        
        let url = APIRoutes.TASK_TIMELOG_PAUSE
        let urlWithTaskId = (url as NSString).stringByReplacingOccurrencesOfString("{task_id}", withString: String(self.toggleTask.taskId))
        
        let requestParams : [String: AnyObject] = ["task": self.toggleTask] //these params is not needed
        
        API.put(urlWithTaskId, parameters: requestParams, callback: { (success, response) in
            if(success) {
                self.timer.invalidate(); //stop timer
                self.currentTaskState = "paused"
                self.pausedTimeInterval = self.currentTimeInterval
                try! self.realm.write {
                    self.toggleTask.taskStatus = "paused"
                }
                
//                self.delegate?.toggleTimer!(self.timer, didPauseTimer: true)
                self.toggleViewDelegate?.toggleTimer!(self.timer, didPauseTimer: true)
                self.taskInfoViewDelegate?.toggleTimer!(self.timer, didPauseTimer: true)
                self.feedViewDelegate?.toggleTimer!(self.timer, didPauseTimer: true)



                onSuccess()
                
            }
            
        })
        
    }
    
    func toggleResumeAction(onSuccess:()->()) {
        if(self.toggleTask.taskId == 0) {
            return
        }

        self.timer.invalidate()
        let url = APIRoutes.TASK_TIMELOG_RESUME
        let urlWithTaskId = (url as NSString).stringByReplacingOccurrencesOfString("{task_id}", withString: String(self.toggleTask.taskId))
        
        let requestParams : [String: AnyObject] = ["task": self.toggleTask] //these params is not needed
        
        API.post(urlWithTaskId, parameters: requestParams, callback: { (success, response) in
            if(success) {
                
                let playingTasks = self.realm.objects(TaskModel).filter("taskStatus = 'in_progress'")
                for playingTask in playingTasks {
                    try! self.realm.write {
                        playingTask.taskStatus = "paused"
                    }
                }
                
                let task = Mapper<TaskModel>().map(response["task"])

                task?.updateTask()
                self.toggleTask = task!
                self.startDate = self.toggleTask.taskUpdatedAt!
                let interval:NSTimeInterval = Double(self.toggleTask.taskDuration)
                self.pausedTimeInterval = interval
                self.currentTaskState = "playing"
                
                self.startTimer()
                //Send Notification
                onSuccess()
                
            }
        })
        
    }
    
    func toggleStopAction(onSuccess: ()->()) {
        if(self.toggleTask.taskId == 0) {
            return
        }
        let url = APIRoutes.TASK_TIMELOG_STOP
        let urlWithTaskId = (url as NSString).stringByReplacingOccurrencesOfString("{task_id}", withString: String(self.toggleTask.taskId))
        
        let requestParams : [String: AnyObject] = ["task": self.toggleTask] //these params is not needed
        
        API.put(urlWithTaskId, parameters: requestParams, callback: { (success, response) in
            if(success) {
                try! self.realm.write {
                    self.toggleTask.taskStatus = "paused"
                }
                
                //sendstopnotification
                self.timer.invalidate();
                self.currentTaskState = "stopped"
                self.toggleViewDelegate?.toggleTimer!(self.timer, didStopTimer: true)

                onSuccess()
                
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
        timeInterval += pausedTimeInterval;
        
        self.currentTimeInterval = timeInterval;
        self.toggledTime = stringFromTimeInterval(timeInterval)
        
        self.timerDelegate?.toggleTimer!(timer, didUpdateTimerWithValue: self.toggledTime) // Assuty
    }
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
}
