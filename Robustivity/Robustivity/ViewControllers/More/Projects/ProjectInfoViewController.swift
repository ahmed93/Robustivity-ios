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
    @IBOutlet weak var projectInfoTableView: UITableView!
//    @IBOutlet weak var projectTasksProgress: UIProgressView!
//    @IBOutlet weak var projectCashProgress: UIProgressView!
//    @IBOutlet weak var projectCustomerSatisfactionProgress: UIProgressView!
//    @IBOutlet weak var projectTasksDoneLabel: UILabel!
//    @IBOutlet weak var projectCashValueLabel: UILabel!
//    @IBOutlet weak var projectCustomerSatisfactionValueLabel: UILabel!
    @IBOutlet weak var projectStatusLabel: UILabel!
    @IBOutlet weak var projectDateLabel: UILabel!
    var projectSponserNumber:String = ""
    
    @IBOutlet var bottomView: UIView!
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
        let nib = UINib(nibName: "ProjectInfoTableSectionFooter", bundle: nil)
        tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: "ProjectInfoTableSectionFooter")

        adapter = ProjectInfoAdapter(viewController: self, tableView: projectInfoTableView, registerCellWithNib:"ProjectMemberCell", withIdentifier: "projectMembers")
        self.title = "Robustivity Project";
    }
    
    func callSponser(sender: UIButton!){
        let phoneNumber = "tel://" + self.projectSponserNumber
        let url:NSURL = NSURL(string: phoneNumber)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    func setData(project:Project){
        projectStatusLabel?.text = project.projectStatus
        projectDateLabel?.text = project.projectEndDate
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
