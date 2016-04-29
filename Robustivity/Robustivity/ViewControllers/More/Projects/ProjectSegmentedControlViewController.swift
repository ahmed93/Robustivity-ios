//
//  ProjectSegmentedControlViewController.swift
//  Robustivity
//
//  Created by Nada Fadali on 4/1/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class ProjectSegmentedControlViewController: BaseViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewsSegmentedControl: UISegmentedControl!
    
    var projectInfoViewController:ProjectInfoViewController?
    var projectTeamViewController:ProjectTeamViewController?
    var projectUpdateViewController:ProjectUpdateViewController?
    var project:Project?
    var sponserNumber = ""
    
    var data = NSMutableArray()
    
    var project_id = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Robustivity Project"
        self.navigationItem.title = "Robustivity Project"
        
        requestProject()
        
        // load intial subview
        viewsSegmentedControl.selectedSegmentIndex = 0
        
        
        
        // style segmented control
        self.viewsSegmentedControl.backgroundColor = Theme.redColor();
        self.viewsSegmentedControl.tintColor = Theme.whiteColor();
        
        
    }
    
    func requestProject() {
        API.get(APIRoutes.SHOW_PROJECT + String(project_id), callback: { (success, response) in
            if(success){
                
                //map the json object to the model and save them
                let projectTeam = Mapper<User>().mapArray(response["members"])
                self.data.addObjectsFromArray(projectTeam!)
                self.showSubView(0)
                                
                // Project Show
                //map the jason object to the model and save them
                let project = Mapper<Project>().map(response["project"])
                project?.projectNumberOfTasks = response["number_of_tasks"] as! Int
                project?.projectTasksDone = response["number_of_completed_tasks"] as! Int
                self.projectInfoViewController?.adapter.saveNewProject(project!)
                self.projectInfoViewController?.setData(project!)
                let projectManagerName:String = (project?.projectManagerName)!
                let projectAccountManagerName:String = (project?.projectAccountManagerName)!
                let projectManagerAvatar:String = (project?.projectManagerAvatar)!
                let projectAccountManagerAvatar:String = (project?.projectAccountManagerAvatar)!
                let projectSponserName:String = (project?.projectSponserName)!
                let billable:Bool = (project?.projectIsBillable)!
                let billAmount:String = String((project?.projectQuotation)!)
                let projectSponserNumber:String = (project?.projectSponserPhone)!
                self.projectInfoViewController?.projectSponserNumber = projectSponserNumber
                self.sponserNumber = (project?.projectSponserPhone)!
                self.projectInfoViewController?.adapter.tableItems.addObject(["name": projectManagerName, "role" : "Project Manager", "type": "1", "avatar": projectManagerAvatar])
                self.projectInfoViewController?.adapter.tableItems.addObject(["name": projectAccountManagerName, "role" : "Account Manager", "type": "1", "avatar": projectAccountManagerAvatar])
                self.projectInfoViewController?.adapter.tableItems.addObject(["name": projectSponserName, "role" : "Spoc", "telephoneNumber": projectSponserNumber ,"type": "2"])
                self.projectInfoViewController?.adapter.tableItems.addObject(["billable": billable, "billAmount" : billAmount , "type": "3"])
                self.projectInfoViewController?.adapter.tableView.reloadData()
            }
        })
    }
    
    
    
    
    func goBackToProjects() {  // this dismisses the view upon click on cancel bar button
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func switchViews(sender: UISegmentedControl) {
        showSubView(sender.selectedSegmentIndex)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Show subview based on the selected segmentedControl
    func showSubView(viewIndex: Int)
    {
        switch viewIndex {
        case 0:
            if projectInfoViewController == nil {
                projectInfoViewController = ProjectInfoViewController(nibName:"ProjectInfoViewController", bundle: nil)
            }
            
            projectInfoViewController!.view.frame = self.containerView.frame
            self.containerView.addSubview(projectInfoViewController!.view)
        case 1:
            if projectUpdateViewController == nil {
                projectUpdateViewController  = ProjectUpdateViewController(nibName:"ProjectUpdateViewController", bundle: nil)
            }
            projectUpdateViewController!.view.frame = self.containerView.frame
            projectUpdateViewController?.setProjectID(project_id)
            self.containerView.addSubview(projectUpdateViewController!.view)
        case 2:
            if projectTeamViewController == nil {
                projectTeamViewController  = ProjectTeamViewController(nibName:"ProjectTeamViewController", bundle: nil)
            }
            projectTeamViewController?.data = data
            projectTeamViewController!.view.frame = self.containerView.frame
            self.containerView.addSubview(projectTeamViewController!.view)
            
        default:
            break
        }
        
        //
        //        self.containerView.subviews[viewIndex].hidden = false
        //        for var i = 0; i < 3; i++ {
        //            if (i != viewIndex) {
        //                self.containerView.subviews[i].hidden = true
        //            }
        //        }
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
