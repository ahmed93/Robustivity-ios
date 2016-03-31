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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dic:NSDictionary = [
            "PersonTableViewCell" : "personCell"
            ,   "DescriptionTableViewCell" : "descriptionCell"]
        infoAdapter = TaskInfoAdapter(viewController: self, tableView: table, registerMultipleNibsAndIdenfifers: dic)
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
