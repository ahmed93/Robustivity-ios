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
        // self.navigationItem.title = "Project Info";
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
