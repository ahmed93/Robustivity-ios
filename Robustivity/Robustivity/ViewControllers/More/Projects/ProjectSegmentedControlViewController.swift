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
    
    var data = NSMutableArray()
    
    var project_id = 1

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
