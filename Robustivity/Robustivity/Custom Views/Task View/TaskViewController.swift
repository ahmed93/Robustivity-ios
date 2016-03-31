//
//  TaskViewController.swift
//  Robustivity
//
//  Created by Mohammad Lotfy on 2016-03-30.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class TaskViewController: BaseViewController {

    var infoAdapter:TaskInfoAdapter!
    var updatesAdapter:TaskUpdatesAdapter!
    @IBOutlet weak var table: UITableView!
    var customSC:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dic:NSDictionary = [
            "PersonTableViewCell" : "personCell"
            ,   "DescriptionTableViewCell" : "descriptionCell"]
        infoAdapter = TaskInfoAdapter(viewController: self, tableView: table, registerMultipleNibsAndIdenfifers: dic)
        self.table.backgroundColor = Theme.lightGrayColor()
    }
    override func loadView() {
        super.loadView()
        
        let items = ["Info", "Updates"]
        customSC = UISegmentedControl(items:items)
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = Theme.redColor()
        customSC.tintColor = UIColor.whiteColor()
        customSC.selectedSegmentIndex = 0
      
        let frame = UIScreen.mainScreen().bounds
        customSC.frame = CGRectMake(frame.minX + 10, frame.minY + 50,
            frame.width - 140, 30)
        self.navigationItem.titleView =  customSC
        customSC.addTarget(self, action: "tabChanged:", forControlEvents: .ValueChanged)
  
}
    
    func tabChanged(sender:UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            let dic:NSDictionary = [
                "PersonTableViewCell" : "personCell"
                ,   "DescriptionTableViewCell" : "descriptionCell"]
            infoAdapter = TaskInfoAdapter(viewController: self, tableView: table, registerMultipleNibsAndIdenfifers: dic)
            break
        case 1:
            updatesAdapter = TaskUpdatesAdapter(viewController: self, tableView: table, registerCellWithNib: "DescriptionTableViewCell", withIdentifier: "descriptionCell")
            break
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
