//
//  SendExcuseViewController.swift
//  Robustivity
//
//  Created by Abdelrahman Saad  on 3/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class SendExcuseViewController: BaseViewController {
    
    @IBOutlet weak var excusesTableView: UITableView!
    var adapter:ExcuseAdapter!


    override func viewDidLoad() { // setting title and bar buttons and footer for the table view
        super.viewDidLoad()
        self.excusesTableView.tableFooterView = UIView()
        self.title = "Send Excuse";
        self.navigationItem.title = "Send Excuse";
        adapter = ExcuseAdapter(viewController: self, tableView: excusesTableView, registerCellWithNib:"ExcuseTableViewCell", withIdentifier: "cell")
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertExcuse")
        self.navigationItem.rightBarButtonItem = addButton
        // Do any additional setup after loading the view.
    }
    
    func insertExcuse () { // this functions is called when + button is clicked to go to write excuse page
        let rg = WriteExcuseViewController(nibName:"WriteExcuseViewController", bundle: nil)
        presentViewController(UINavigationController(rootViewController: rg), animated: true) { () -> Void in
        }
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
