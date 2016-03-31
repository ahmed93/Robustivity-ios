//
//  ProjectUpdateViewController.swift
//  Robustivity
//
//  Created by Nada Fadali on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProjectUpdateViewController: BaseViewController {
    
    @IBOutlet weak var projectUpdateTableView: UITableView!
    var adapter: ProjectUpdateAdapter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Project Updates";
        self.navigationItem.title = "Project Update";
        
        adapter = ProjectUpdateAdapter(viewController: self, tableView: projectUpdateTableView, registerCellWithNib:"ProjectUpdateTableViewCell", withIdentifier: "projectUpdateCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("ProjectUpdateViewController", owner: self, options: nil)
    }
    
    override func loadView() {
        super.loadView()
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
