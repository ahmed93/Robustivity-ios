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


//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        NSBundle.mainBundle().loadNibNamed("SendExcuseViewController", owner: self, options: nil)
//    }
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.excusesTableView.tableFooterView = UIView()
        self.title = "Send Excuse";
        self.navigationItem.title = "Send Excuse";
        adapter = ExcuseAdapter(viewController: self, tableView: excusesTableView, registerCellWithNib:"BaseTableViewCell", withIdentifier: "cell")
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertExcuse")
        self.navigationItem.rightBarButtonItem = addButton
        // Do any additional setup after loading the view.
    }
    
    func insertExcuse () {
        let rg = WriteExcuseViewController(nibName:"WriteExcuseViewController", bundle: nil)
        presentViewController(UINavigationController(rootViewController: rg), animated: true) { () -> Void in
        }
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
