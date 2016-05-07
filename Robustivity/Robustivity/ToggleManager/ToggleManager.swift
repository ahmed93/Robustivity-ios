//
//  ToggleManager.swift
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

    private var timer = NSTimer();
    private var timerStartDate: NSDate?;
    
    let realm = try! Realm()
    private var toggledTaskDuration: String? {
        get {
            guard let toggledTask = toggledTask else {
                return nil
            }
            
            return stringFromTimeInterval(Double(toggledTask.taskDuration))
        }
    }
    
    private var toggledTime = "00:00:00"
    
    private var toggledTask:TaskModel? {
        willSet{
            guard let toggledTask = toggledTask else { return }
            guard let newValue = newValue else { return }
            delegate?.toggleManager?(self, willChangeToggledTask: toggledTask, newTask: newValue, toggledTime: toggledTaskDuration!)
        }
        
        didSet {
            guard let toggledTask = toggledTask else { return }
            delegate?.toggleManager(self, didChangeToggledTask: toggledTask, toggledTime: toggledTaskDuration!)
        }
    }
    
    weak var delegate: ToggleManagerDelegate? {
        didSet {
            delegate?.toggleManager(self, hasTask: toggledTask, toggledTime: toggledTaskDuration)
        }
    }
    
    
    func fetchInProgressTask() {
        guard let task = TaskModel.inProgress() else { return }
        self.toggledTask = task
        self.startTimer()
    }
    
    
    // MARK: Timer Actions
    private func startTimer() {
        guard let toggledTask = toggledTask else { return }

        self.delegate?.toggleManager?(self, willStartTimer: toggledTaskDuration!, forTask: toggledTask)
        timerStartDate = NSDate()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateToggledTime"), userInfo: nil, repeats: true)
        self.delegate?.toggleManager?(self, didStartTimer: toggledTaskDuration!, forTask: toggledTask)
    }
    
    private func resumeTimer() {
        guard let toggledTask = toggledTask else { return }
        
        self.delegate?.toggleManager?(self, willResumeTimer: toggledTime, forTask: toggledTask)
        timerStartDate = NSDate()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateToggledTime"), userInfo: nil, repeats: true)
        self.delegate?.toggleManager?(self, didResumeTimer: toggledTime, forTask: toggledTask)
    }
    
    private func pauseTimer() {
        guard let toggledTask = toggledTask else {
            return
        }

        self.delegate?.toggleManager?(self, willPauseTimer: toggledTaskDuration!, forTask: toggledTask)
        self.timer.invalidate()
        self.delegate?.toggleManager?(self, didPauseTimer: toggledTaskDuration!, forTask: toggledTask)
    }

    private func stopTimer() {
        guard let toggledTask = toggledTask else {
            return
        }

        self.delegate?.toggleManager?(self, willStopTimer: toggledTaskDuration!, forTask: toggledTask)
        self.timer.invalidate()
        self.delegate?.toggleManager?(self, didStopTimer: toggledTaskDuration!, forTask: toggledTask)
    }
    
    // MARK: Task Actions
    func resumeCurrentTask(onSuccess: (() -> ())? = nil, onFailure: (() -> ())? = nil) {
        guard let toggledTask = toggledTask else { return }
        
        let url = formatURL(APIRoutes.TASK_TIMELOG_RESUME, stringToReplace: "task_id", with: toggledTask.taskId)
        
        self.timer.invalidate()
        API.post(url, callback: { [unowned self] (success, response) in
            if(success) {
                
                self.invalidateInProgressTasks()
                
                let task = Mapper<TaskModel>().map(response["task"])
                task?.updateTask()

                self.toggledTask = task!
                self.startTimer()

                onSuccess?()
            } else {
                self.resumeTimer()
                onFailure?()
            }
        })
    }
    
    func pauseCurrentTask(onSuccess: (() -> ())? = nil, onFailure: (() -> ())? = nil) {
        guard let toggledTask = toggledTask else { return }
        
        let url = formatURL(APIRoutes.TASK_TIMELOG_PAUSE, stringToReplace: "task_id", with: toggledTask.taskId)
        
        timer.invalidate()
        API.put(url, callback: { [unowned self] (success, response) in
            if(success) {

                let duration = response["total_logged_time"] as? Int
                try! self.realm.write {
                    toggledTask.taskStatus = "paused"
                    toggledTask.taskDuration = duration!
                }

                self.pauseTimer()
                onSuccess?()

            } else {
                self.resumeTimer()
                onFailure?()
            }
        })
    }
    
    func stopCurrentTask(onSuccess: (() -> ())? = nil, onFailure: (() -> ())? = nil) {
        guard let toggledTask = toggledTask else { return }
        
        let url = formatURL(APIRoutes.TASK_TIMELOG_STOP, stringToReplace: "task_id", with: toggledTask.taskId)
        
        self.timer.invalidate();
        API.put(url, callback: { [unowned self] (success, response) in
            if(success) {
                let duration = response["total_logged_time"] as? Int
                try! self.realm.write {
                    toggledTask.taskStatus = "paused"
                    toggledTask.taskDuration = duration!
                }
                self.stopTimer()

                self.toggledTask = nil
                self.toggledTime = "00:00:00"

                onSuccess?()
            } else {
                self.resumeTimer()
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
    private func formatURL(var url: String, stringToReplace name: String, with value: Int) -> String {
        url = (url as NSString).stringByReplacingOccurrencesOfString("{\(name)}", withString: String(value))
        return url
    }
    
    private func invalidateInProgressTasks() {
        let tasks = self.realm.objects(TaskModel).filter("taskStatus = 'in_progress'")
        try! self.realm.write {
            tasks.setValue("paused", forKey: "taskStatus")
        }
    }
    
    /*
    ** updateToggledTime
    ** CallBack function for NStimer
    ** compares users's current time with saved start time and
    ** update counter accordingly
    */
    
    // MARK: old
    @objc private func updateToggledTime() {
        // Create date from the elapsed time
        let currentDate = NSDate();
        var timeInterval = currentDate.timeIntervalSinceDate(timerStartDate!);
        timeInterval += Double(toggledTask!.taskDuration);
        self.toggledTime = stringFromTimeInterval(timeInterval)
        self.delegate?.toggleManager?(self, didUpdateTimer: self.toggledTime) // Assuty
    }
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
