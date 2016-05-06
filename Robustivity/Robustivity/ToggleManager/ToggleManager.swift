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

@objc class ToggleManager : NSObject {
    class var sharedInstance: ToggleManager {
        struct Static {
            static var instance: ToggleManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ToggleManager()
        }
        
        return Static.instance!
    }

    var timer = NSTimer();
    var startDate = NSDate();
    var currentTimeInterval = NSTimeInterval();
    var pausedTimeInterval = NSTimeInterval();
    let realm = try! Realm()
    var toggledTime = "00:00:00"
    
    var toggledTask:TaskModel? {
        willSet{
            guard let toggledTask = toggledTask else { return }
            guard let newValue = newValue else { return }
            delegate?.toggleManager?(self, willChangeToggledTask: toggledTask, newTask: newValue, toggledTime: toggledTime)
        }
        
        didSet {
            guard let toggledTask = toggledTask else { return }
            delegate?.toggleManager(self, didChangeToggledTask: toggledTask, toggledTime: toggledTime)
        }
    }
    
    var delegate: ToggleManagerDelegate? {
        didSet {
            guard let toggledTask = toggledTask else { return }
            delegate?.toggleManager(self, hasTask: toggledTask, toggledTime: toggledTime)
        }
    }
    
    
    func fetchInProgressTask() {
        guard let task = TaskModel.inProgress() else { return }
        
        self.toggledTask = task
        let interval:NSTimeInterval = Double(task.taskDuration)
        self.pausedTimeInterval = interval
        self.startDate = task.taskUpdatedAt!
        self.startTimer()
    }
    
    
    // MARK: Timer Actions
    private func startTimer() {
        guard let toggledTask = toggledTask else { return }

        self.delegate?.toggleManager?(self, willStartTimer: toggledTime, forTask: toggledTask)
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateToggledTime"), userInfo: nil, repeats: true);

        self.delegate?.toggleManager?(self, didStartTimer: toggledTime, forTask: toggledTask)
    }
    
    private func pauseTimer() {
        guard let toggledTask = toggledTask else {
            return
        }

        self.delegate?.toggleManager?(self, willPauseTimer: toggledTime, forTask: toggledTask)
        self.timer.invalidate()
        self.delegate?.toggleManager?(self, didPauseTimer: toggledTime, forTask: toggledTask)
    }

    private func stopTimer() {
        guard let toggledTask = toggledTask else {
            return
        }

        self.delegate?.toggleManager?(self, willStopTimer: toggledTime, forTask: toggledTask)
        self.timer.invalidate()
        self.delegate?.toggleManager?(self, didStopTimer: toggledTime, forTask: toggledTask)
    }
    
    // MARK: Task Actions
    func resumeCurrentTask(onSuccess: (() -> ())? = nil, onFailure: (() -> ())? = nil) {
        guard let toggledTask = toggledTask else { return }
        
        let url = formatURL(APIRoutes.TASK_TIMELOG_RESUME, stringToReplace: "task_id", with: toggledTask.taskId)
        
        self.timer.invalidate()
        API.post(url, callback: { (success, response) in
            if(success) {
                
                self.invalidateInProgressTasks()
                
                let task = Mapper<TaskModel>().map(response["task"])
                task?.updateTask()

                self.toggledTask = task!
                
                self.startDate = self.toggledTask!.taskUpdatedAt!
                let interval:NSTimeInterval = Double(self.toggledTask!.taskDuration)
                self.pausedTimeInterval = interval
                
                self.startTimer()
                onSuccess?()
            } else {
                self.startTimer()
                onFailure?()
            }
        })
    }
    
    func pauseCurrentTask(onSuccess: (() -> ())? = nil, onFailure: (() -> ())? = nil) {
        guard let toggledTask = toggledTask else { return }
        
        let url = formatURL(APIRoutes.TASK_TIMELOG_PAUSE, stringToReplace: "task_id", with: toggledTask.taskId)
        
        timer.invalidate()
        API.put(url, callback: { (success, response) in
            if(success) {
                self.pausedTimeInterval = self.currentTimeInterval
                
                try! self.realm.write {
                    toggledTask.taskStatus = "paused"
                }

                self.pauseTimer()
                onSuccess?()

            } else {
                self.startTimer()
                onFailure?()
            }
        })
    }
    
    func stopCurrentTask(onSuccess: (() -> ())? = nil, onFailure: (() -> ())? = nil) {
        guard let toggledTask = toggledTask else { return }
        
        let url = formatURL(APIRoutes.TASK_TIMELOG_STOP, stringToReplace: "task_id", with: toggledTask.taskId)
        
        self.timer.invalidate();
        API.put(url, callback: { (success, response) in
            if(success) {
                try! self.realm.write {
                    toggledTask.taskStatus = "paused"
                }

                self.stopTimer()
                self.toggledTask = nil
                onSuccess?()
            } else {
                self.startTimer()
                onFailure?()
            }
        })
    }

    func playNewTask(task: TaskModel, onSuccess: (() -> ())? = nil, onFailure: (() -> ())? = nil) {
        if (task.taskId == toggledTask?.taskId) {
            resumeCurrentTask(onSuccess, onFailure: onFailure)
            return
        }
        
        func startNewTask() {
            toggledTask = task
            resumeCurrentTask(onSuccess, onFailure: onFailure)
        }
        
        guard let _ = toggledTask else {
            startNewTask()
            return
        }
        stopCurrentTask(startNewTask)
    }
    
    // MARK: Helper Methods
    func formatURL(var url: String, stringToReplace name: String, with value: Int) -> String {
        url = (url as NSString).stringByReplacingOccurrencesOfString("{\(name)}", withString: String(value))
        return url
    }
    
    func invalidateInProgressTasks() {
        let tasks = self.realm.objects(TaskModel).filter("taskStatus = 'in_progress'")
        try! self.realm.write {
            tasks.setValue("paused", forKey: "taskStatus")
        }
    }
    
    // old
//    func togglePauseAction(onSuccess: (()->())?) {
//        guard let toggledTask = toggledTask else { return }
//        
//        let url = formatURL(APIRoutes.TASK_TIMELOG_PAUSE, stringToReplace: "task_id", with: toggledTask.taskId)
//        let requestParams : [String: AnyObject] = ["task": toggledTask] //these params is not needed
//        
//        self.timer.invalidate(); //stop timer
//        API.put(url, parameters: requestParams, callback: { (success, response) in
//            if(success) {
//                self.pausedTimeInterval = self.currentTimeInterval
//                try! self.realm.write {
//                    toggledTask.taskStatus = "paused"
//                }
//                
////                self.delegate?.toggleManager?(self, didPauseTimer: self.toggledTime, forTask: toggledTask)
//                self.pauseTimer()
//
//                onSuccess?()
//            } else {
//                self.startTimer()
//            }
//        })
//        
//    }
    
//    func toggleResumeAction(){
//        toggleResumeAction(toggledTask!) { }
//    }
    
//    func toggleResumeAction(newTask: TaskModel, onSuccess:()->()) {
//        let url = formatURL(APIRoutes.TASK_TIMELOG_RESUME, stringToReplace: "task_id", with: toggledTask!.taskId)
//        let requestParams : [String: AnyObject] = ["task": newTask] //these params is not needed
//        
//        self.timer.invalidate()
//        API.post(url, parameters: requestParams, callback: { (success, response) in
//            if(success) {
//                // ***probably wrong log time for old task
//                let playingTasks = self.realm.objects(TaskModel).filter("taskStatus = 'in_progress'")
//                for playingTask in playingTasks {
//                    try! self.realm.write {
//                        playingTask.taskStatus = "paused"
//                    }
//                }
//                
//                let task = Mapper<TaskModel>().map(response["task"])
//
//                task?.updateTask()
//                self.toggledTask = task!
//                self.startDate = self.toggledTask!.taskUpdatedAt!
//                let interval:NSTimeInterval = Double(self.toggledTask!.taskDuration)
//                self.pausedTimeInterval = interval
//                
//                self.startTimer()
//
//                onSuccess()
//                
//            } else {
//                self.startTimer()
//            }
//        })
//        
//    }
    
//    func toggleStopAction(onSuccess: ()->()) {
//        guard let toggledTask = toggledTask else { return }
//        
//        let url = formatURL(APIRoutes.TASK_TIMELOG_STOP, stringToReplace: "task_id", with: toggledTask.taskId)
//        let requestParams : [String: AnyObject] = ["task": toggledTask] //these params is not needed
//
//        self.timer.invalidate();
//        API.put(url, parameters: requestParams, callback: { (success, response) in
//            if(success) {
//                try! self.realm.write {
//                    toggledTask.taskStatus = "paused"
//                }
//                
//                self.stopTimer()
//                onSuccess()
//            } else {
//                self.startTimer()
//            }
//        })
//    }
    
    /*
    ** updateToggledTime
    ** CallBack function for NStimer
    ** compares users's current time with saved start time and
    ** update counter accordingly
    */
    
    // MARK: old
    @objc func updateToggledTime() {
        // Create date from the elapsed time
        let currentDate = NSDate();
        var timeInterval = currentDate.timeIntervalSinceDate(self.startDate);
        timeInterval += pausedTimeInterval;
        
        self.currentTimeInterval = timeInterval;
        self.toggledTime = stringFromTimeInterval(timeInterval)
        
    
        guard let _ = toggledTask else { return }
        self.delegate?.toggleManager?(self, didUpdateTimer: self.toggledTime) // Assuty
    }
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func changeToggledTask(task: TaskModel) {
        print(task)
        print("------------------------")
        toggledTask = task
        startDate = NSDate()
        startTimer()
    }
    
    
}
