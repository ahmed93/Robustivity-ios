//
//  ProjectInfoTableSectionFooter.swift
//  Robustivity
//
//  Created by Almgohar on 4/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectInfoTableSectionFooter: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var projectTasksProgress: UIProgressView!
    @IBOutlet weak var projectCashProgress: UIProgressView!
    @IBOutlet weak var projectCustomerSatisfactionProgress: UIProgressView!
    @IBOutlet weak var projectTasksDoneLabel: UILabel!
    @IBOutlet weak var projectCashValueLabel: UILabel!
    @IBOutlet weak var projectCustomerSatisfactionValueLabel: UILabel!

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
      
    func customizeUI(){
        projectTasksProgress?.tintColor = Theme.greenColor()
        projectTasksProgress?.trackTintColor = Theme.whiteColor()
        projectTasksProgress?.layer.borderWidth = 0.7
        projectTasksProgress?.layer.borderColor = Theme.greenColor().CGColor
        projectTasksDoneLabel?.textColor = Theme.greenColor()
        
        projectCashProgress?.tintColor = Theme.blueColor()
        projectCashProgress?.trackTintColor = Theme.whiteColor()
        projectCashProgress?.layer.borderWidth = 0.7
        projectCashProgress?.layer.borderColor = Theme.blueColor().CGColor
        projectCashValueLabel?.textColor = Theme.blueColor()
        
        projectCustomerSatisfactionProgress?.tintColor = Theme.purpleColor()
        projectCustomerSatisfactionProgress?.trackTintColor = Theme.whiteColor()
        projectCustomerSatisfactionProgress?.layer.borderWidth = 0.7
        projectCustomerSatisfactionProgress?.layer.borderColor = Theme.purpleColor().CGColor
    }
    
    func setData(project:Project){
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


}
