//
//  ProjectSegmentedControlViewController.swift
//  Robustivity
//
//  Created by Nada Fadali on 4/1/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectSegmentedControlViewController: BaseViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewsSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var projectInfoViewController: ProjectInfoViewController!
    @IBOutlet weak var projectTeamViewController: ProjectTeamViewController!
    @IBOutlet weak var projectUpdateViewController: ProjectUpdateViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Robustivity Project"
        self.navigationItem.title = "Robustivity Project"
        
        // load subviews
        self.containerView.addSubview(projectInfoViewController.view)
        self.containerView.addSubview(projectUpdateViewController.view)
        self.containerView.addSubview(projectTeamViewController.view)
        
        // load intial subview
        viewsSegmentedControl.selectedSegmentIndex = 0
        showSubView(0)
        
        let goBackToProjectsBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "goBackToProjects")
        self.navigationItem.leftBarButtonItem = goBackToProjectsBtn

        // style segmented control
        self.viewsSegmentedControl.backgroundColor = Theme.redColor();
        self.viewsSegmentedControl.tintColor = Theme.whiteColor();
        
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
