//
//  ProfileDirectoryViewController.swift
//  Robustivity
//
//  Created by MacBook Pro on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProfileDirectoryViewController: BaseViewController {


        
    
    @IBOutlet weak var tableView: UITableView!
        var adapter:ProfileDirectoryAdapter!
        
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            NSBundle.mainBundle().loadNibNamed("MoreViewController", owner: self, options: nil)
        }
        
        override func loadView() {
            super.loadView()
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // setting View TabBartitle + navigationBarTitle
            
            self.title = "More";
            self.navigationItem.title = "Directory";
            
            
            adapter = ProfileDirectoryAdapter(viewController: self, tableView: tableView, registerCellWithNib:"ProfileDirectoryCell", withIdentifier: "cell")
        }
        
        
}
