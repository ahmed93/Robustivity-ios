//
//  FeedViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class FeedViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var adapter:FeedAdapter!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("FeedViewController", owner: self, options: nil)
    }

    override func loadView() {
        super.loadView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Feed"
        adapter = FeedAdapter(viewController: self, tableView: tableView, cellIdentifier: "cell")
        
        
    }
    
    
    

}
