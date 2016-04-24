//
//  DirectoryViewController.swift
//  Robustivity
//
//  Created by MacBook Pro on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class DirectoryViewController: BaseViewController {


    @IBOutlet weak var tableView: UITableView!
    var adapter:DirectoryAdapter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // setting View TabBartitle + navigationBarTitle
        
        self.title = "More";
        self.navigationItem.title = "Directory";
        
        
        adapter = DirectoryAdapter(viewController: self, tableView: tableView, registerCellWithNib:"DirectoryCell", withIdentifier: "cell")
    }
        
        
}
