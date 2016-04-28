//
//  PingToUsersViewController.swift
//  Robustivity
//
//  Created by Almgohar on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class PingToUsersViewController: BaseViewController {

    var adapter:PingAdapter!
    var model:Ping?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ping To";
        adapter = PingAdapter(viewController: self, tableView: tableView, registerCellWithNib:"PingToUserTableViewCell", withIdentifier: "cell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLineEtched
        self.tableView.allowsMultipleSelection = true
        let doneChooseButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(makeChoice))
        self.navigationItem.leftBarButtonItem = doneChooseButton
       
        // Do any additional setup after loading the view.
    }
    
    func makeChoice() {
        navigationController?.popViewControllerAnimated(true)

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
