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
        let doneChooseButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "makeChoice")
        self.navigationItem.rightBarButtonItem = doneChooseButton
       
        let cancelPingButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelSelection")
        self.navigationItem.leftBarButtonItem = cancelPingButton
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.tabBarController?.tabBar.hidden = true
    }
    
    func makeChoice() {
        for user in adapter.selectedUsers {
            if(!Ping.selectedUsers.contains(user)) {
                Ping.selectedUsers.append(user)
            }
        }
        
        for userPic in adapter.selectedUsersPics {
            if(!Ping.selectedUsersPics.contains(userPic)) {
                print(userPic)
                Ping.selectedUsersPics.append(userPic)
            }
        }
        
        for deselectedUser in adapter.deselectedUsers {
            if(Ping.selectedUsers.contains(deselectedUser)) {
                Ping.selectedUsers.removeAtIndex(Ping.selectedUsers.indexOf(deselectedUser)!)
            }
        }
        
        for deselectedUserPic in adapter.deselectedUsersPics {
            if(Ping.selectedUsersPics.contains(deselectedUserPic)) {
                Ping.selectedUsersPics.removeAtIndex(Ping.selectedUsersPics.indexOf(deselectedUserPic)!)
            }
        }
        
        print(adapter.selectedUsersPics)
        navigationController?.popViewControllerAnimated(true)

    }
    
    func cancelSelection() {
        adapter.selectedUsers.removeAll()
        adapter.selectedUsersPics.removeAll()
        adapter.deselectedUsersPics.removeAll()
        adapter.deselectedUsers.removeAll()
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
