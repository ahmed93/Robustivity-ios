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
  

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  var adapter: ProjectsListAdapter!
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    NSBundle.mainBundle().loadNibNamed("ProjectsListViewController", owner: self, options: nil)
  }
  
  override func loadView() {
    super.loadView()
  }
  
  
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
