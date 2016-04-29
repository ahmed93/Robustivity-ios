//
//  ProjectInfoViewController.swift
//  Robustivity
//
//  Created by Abanoub Aziz on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectInfoViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var projectInfoTableView: UITableView!
    @IBOutlet weak var projectTasksProgress: UIProgressView!
    @IBOutlet weak var projectCashProgress: UIProgressView!
    @IBOutlet weak var projectCustomerSatisfactionProgress: UIProgressView!
    @IBOutlet weak var projectTasksDoneLabel: UILabel!
    @IBOutlet weak var projectCashValueLabel: UILabel!
    @IBOutlet weak var projectCustomerSatisfactionValueLabel: UILabel!
    @IBOutlet weak var projectStatusLabel: UILabel!
    @IBOutlet weak var projectDateLabel: UILabel!
    var projectSponserNumber:String = ""
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var adapter: ProjectInfoAdapter!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter = ProjectInfoAdapter(viewController: self, tableView: projectInfoTableView, registerCellWithNib:"ProjectMemberCell", withIdentifier: "projectMembers")
        self.title = "Robustivity Project";
        customizeUI()
    }
    
    func callSponser(sender: UIButton!){
        let phoneNumber = "tel://" + self.projectSponserNumber
        let url:NSURL = NSURL(string: phoneNumber)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    func setData(project:Project){
        projectStatusLabel?.text = project.projectStatus
        projectDateLabel?.text = project.projectEndDate
        let tasksValue = Float(project.projectTasksDone) / Float(project.projectNumberOfTasks)
        projectTasksDoneLabel?.text = "\(String(project.projectTasksDone))/\(String(project.projectNumberOfTasks))"
        projectTasksProgress?.progress = tasksValue
        let cashValue = Float(project.projectActualCost) / Float(project.projectPlannedCost)
        projectCashValueLabel?.text = "\(String(project.projectActualCost))/\(String(project.projectPlannedCost))"
        projectCashProgress?.progress = cashValue
        let customerSatisification = project.projectCustomerStatisfaction
        projectCustomerSatisfactionValueLabel?.text = customerSatisification
        if(customerSatisification == "high"){
            projectCustomerSatisfactionProgress?.progress = 1.0
        }else if (customerSatisification == "medium"){
            projectCustomerSatisfactionProgress?.progress = 0.5
        }else{
            projectCustomerSatisfactionProgress?.progress = 0.0
        }
    }
    
    func customizeUI(){
        projectTasksProgress?.tintColor = Theme.greenColor();
        projectTasksProgress?.trackTintColor = Theme.whiteColor();
        projectTasksProgress?.layer.borderWidth = 0.7
        projectTasksProgress?.layer.borderColor = Theme.greenColor().CGColor
        projectTasksDoneLabel?.textColor = Theme.greenColor()
        
        projectCashProgress?.tintColor = Theme.blueColor();
        projectCashProgress?.trackTintColor = Theme.whiteColor();
        projectCashProgress?.layer.borderWidth = 0.7
        projectCashProgress?.layer.borderColor = Theme.blueColor().CGColor
        projectCashValueLabel?.textColor = Theme.blueColor()
        
        projectCustomerSatisfactionProgress?.tintColor = Theme.purpleColor();
        projectCustomerSatisfactionProgress?.trackTintColor = Theme.whiteColor();
        projectCustomerSatisfactionProgress?.layer.borderWidth = 0.7
        projectCustomerSatisfactionProgress?.layer.borderColor = Theme.purpleColor().CGColor
        projectCustomerSatisfactionValueLabel?.textColor = Theme.purpleColor()
        
//        projectStatusLabel?.textColor = Theme.greenColor()
//        projectDateLabel?.textColor = Theme.redColor()
//        
//        self.tableView.addSubview(projectTasksDoneLabel)
//        self.tableView.addSubview(projectTasksProgress)
//        
//        self.tableView.addSubview(projectCashValueLabel)
//        self.tableView.addSubview(projectCashProgress)
//
//        self.tableView.addSubview(projectCustomerSatisfactionValueLabel)
//        self.tableView.addSubview(projectTasksProgress)

//        self.tableView.tableFooterView = self.footerView
        
    

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
