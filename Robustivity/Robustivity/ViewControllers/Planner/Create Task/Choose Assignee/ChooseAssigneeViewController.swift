//
//  ChooseAssigneeViewController.swift
//  Robustivity
//
//  Created by Mahmoud Eldesouky on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

// CreateTask_ChooseAssignee viewController
class ChooseAssigneeViewController: BaseViewController {

    var adapter:UserAdapter!
    var project_id:Int!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Assign To";
        self.navigationController!.navigationBar.barTintColor = Theme.redColor()
        adapter = UserAdapter(viewController: self, tableView: tableView, registerCellWithNib:"UserTableViewCell", withIdentifier: "cell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None

        let backItem = UIBarButtonItem()
        backItem.title = "Assign"
        navigationItem.backBarButtonItem = backItem
        // Do any additional setup after loading the view.
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
