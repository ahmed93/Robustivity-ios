//
//  ProjectInfoViewController.swift
//  Robustivity
//
//  Created by Abanoub Aziz on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectInfoViewController: BaseViewController {
    
    @IBOutlet weak var projectInfoTableView: UITableView!
    @IBOutlet weak var projectTasksProgress: UIProgressView!
    @IBOutlet weak var projectCashProgress: UIProgressView!
    @IBOutlet weak var projectCustomerSatisfactionProgress: UIProgressView!
    @IBOutlet weak var projectTasksDoneLabel: UILabel!
    @IBOutlet weak var projectCashValueLabel: UILabel!
    @IBOutlet weak var projectCustomerSatisfactionValueLabel: UILabel!
    @IBOutlet weak var projectStatusLabel: UILabel!
    @IBOutlet weak var projectDateLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var adapter: ProjectInfoAdapter!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("ProjectInfoViewController", owner: self, options: nil)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Robustivity Project";
        
        projectTasksProgress?.tintColor = Theme.greenColor();
        projectTasksProgress?.trackTintColor = Theme.whiteColor();
        projectTasksProgress?.setProgress(0.3, animated: true)
        projectTasksProgress?.layer.borderWidth = 0.7
        projectTasksProgress?.layer.borderColor = Theme.greenColor().CGColor
        projectTasksDoneLabel?.text = "23/30"
        projectTasksDoneLabel?.textColor = Theme.greenColor()
        
        projectCashProgress?.tintColor = Theme.blueColor();
        projectCashProgress?.trackTintColor = Theme.whiteColor();
        projectCashProgress?.setProgress(0.5, animated: true)
        projectCashProgress?.layer.borderWidth = 0.7
        projectCashProgress?.layer.borderColor = Theme.blueColor().CGColor
        projectCashValueLabel?.text = "$100"
        projectCashValueLabel?.textColor = Theme.blueColor()
        
        projectCustomerSatisfactionProgress?.tintColor = Theme.purpleColor();
        projectCustomerSatisfactionProgress?.trackTintColor = Theme.whiteColor();
        projectCustomerSatisfactionProgress?.setProgress(1.0, animated: true)
        projectCustomerSatisfactionProgress?.layer.borderWidth = 0.7
        projectCustomerSatisfactionProgress?.layer.borderColor = Theme.purpleColor().CGColor
        projectCustomerSatisfactionValueLabel?.text = "100%"
        projectCustomerSatisfactionValueLabel?.textColor = Theme.purpleColor()
        
        projectStatusLabel?.text = "In Progress"
        projectStatusLabel?.textColor = Theme.greenColor()
        projectDateLabel?.text = "Oct 15, 2015"
        projectDateLabel?.textColor = Theme.redColor()
        
        adapter = ProjectInfoAdapter(viewController: self, tableView: projectInfoTableView, registerCellWithNib:"ProjectMemberCell", withIdentifier: "projectMembers")
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
