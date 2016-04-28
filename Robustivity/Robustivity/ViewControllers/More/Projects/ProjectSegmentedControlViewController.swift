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
    
    @IBOutlet weak var projectInfoViewController: ProjectInfoViewController!
    @IBOutlet weak var projectTeamViewController: ProjectTeamViewController!
    @IBOutlet weak var projectUpdateViewController: ProjectUpdateViewController!
    
    var project_id:Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Robustivity Project"
        self.navigationItem.title = "Robustivity Project"

        //self.projectInfoViewController.project_id = self.project_id
        //self.projectUpdateViewController.project_id = self.project_id
        //self.projectTeamViewController.project_id = self.project_id
        // load subviews
        self.containerView.addSubview(projectInfoViewController.view)
        self.containerView.addSubview(projectUpdateViewController.view)
        self.containerView.addSubview(projectTeamViewController.view)
        
        // load intial subview
        viewsSegmentedControl.selectedSegmentIndex = 0
        showSubView(0)
     //   let goBackToProjectsBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "goBackToProjects")
    //    self.navigationItem.leftBarButtonItem = goBackToProjectsBtn

        // style segmented control
        self.viewsSegmentedControl.backgroundColor = Theme.redColor();
        self.viewsSegmentedControl.tintColor = Theme.whiteColor();
        
        requestProject()
    }
    
    func requestProject() {
        API.get(APIRoutes.SHOW_PROJECT + String(project_id), callback: { (success, response) in
            if(success){
                //map the json object to the model and save them
                let projectTeam = Mapper<User>().mapArray(response["members"])
                for member in projectTeam! {
                    self.projectTeamViewController.adapter.tableItems.addObject(member)
                }
                print(self.projectTeamViewController.adapter.tableItems.count)
                self.projectTeamViewController.adapter.tableView.reloadData()
                print(self.projectTeamViewController.adapter.tableItems.count)


                
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
        self.containerView.subviews[viewIndex].hidden = false
        for var i = 0; i < 3; i++ {
            if (i != viewIndex) {
                self.containerView.subviews[i].hidden = true
            }
        }
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
