//
//  ProjectsListViewController.swift
//  Robustivity
//
//  Created by Mariam Mohamed Fawzy on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectsListViewController: BaseViewController {

  @IBOutlet weak var projectsTableView: UITableView!
    var adapter: ProjectsListAdapter!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    // setting View TabBartitle + navigationBarTitle
    self.title = "My Projects";
    self.navigationItem.title = "My Projects";
    
    adapter = ProjectsListAdapter(viewController: self, tableView: projectsTableView, registerCellWithNib:"CustomProjectsListTableViewCell", withIdentifier: "listProjectCell")
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
