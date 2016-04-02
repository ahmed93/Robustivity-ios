//
//  ChooseProjectViewController.swift
//  Robustivity
//
//  Created by Mahmoud Eldesouky on 4/2/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ChooseProjectViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var adapter:ListProjectsAdapter!
    var isTodo:Bool!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Project";
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ChooseProjectViewController.cancelAction(_:)))
       
        let backItem = UIBarButtonItem()
        backItem.title = "Projects"
        navigationItem.backBarButtonItem = backItem
        
        adapter = ListProjectsAdapter(viewController: self, tableView: tableView, registerCellWithNib:"UserTableViewCell", withIdentifier: "cell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None

    }
    func isTodo(isTodo: Bool){
        self.isTodo = isTodo
    }
    func getTodo() -> Bool{
        return self.isTodo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func cancelAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
