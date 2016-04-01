//
//  ProjectTeamViewController.swift
//  Robustivity
//
//  Created by Abdelrahman Zaky on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectTeamViewController: BaseViewController {

    @IBOutlet weak var membersTableView: UITableView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var adapter: ProjectMembersAdapter!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("ProjectTeamViewController", owner: self, options: nil)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setting View TabBartitle + navigationBarTitle
        self.title = "Project Members";
        self.navigationItem.title = "Project Members";
        
        adapter = ProjectMembersAdapter(viewController: self, tableView: membersTableView!, registerCellWithNib:"ProjectMemberCell", withIdentifier: "projectMembers")
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
