//
//  MoreViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.


import UIKit

/*
This Class is controlling the More View page attributes,
the table view,
the UI profile view

Edited by: Mayar ElMohr, Salma Amr, Nouran Mamdouh on 3/31/16.
*/

class MoreViewController: BaseViewController {


    @IBOutlet weak var logOut: UIButton!
    
    @IBOutlet weak var jobTitle: UILabel!


    @IBOutlet weak var checkInTimeLabel: UILabel!
    @IBOutlet weak var checkInSwitch: UISwitch!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var profileMore: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var checkedInLabel: UILabel!
    var adapter:OptionsTableAdapter!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("MoreViewController", owner: self, options: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "More";
        self.navigationItem.title = "More";
        let call = UIBarButtonItem(image: UIImage(named: "call_white"), style: .Plain, target: self, action: NSSelectorFromString("callView"))
        navigationItem.rightBarButtonItem = call
        
        initMore();
    }
    
    /*
    The Method styles the profile UIView and intializes the adapter 
    to fill the table customized cells.
    
    Edited by: Mayar ElMohr, Salma Amr, Nouran Mamdouh on 3/31/16.
    */
    
    func initMore(){
        
        /** Setting backround color **/
        self.profileMore.backgroundColor = Theme.getColor(Color.lightGray);
        
        /** Creating a shadow after the UIView **/

        self.profileMore.clipsToBounds = false;
        self.profileMore.layer.shadowColor = Theme.getColor(Color.black).CGColor;
        self.profileMore.layer.shadowOffset = CGSizeMake(0,3);
        self.profileMore.layer.shadowOpacity = 0.5;

        
        /** a Rounded avatar **/
        self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
        self.avatar.clipsToBounds = true;
       
        /** Styling labels **/
        Theme.style_2(self.checkedInLabel);
        Theme.style_2(self.checkInTimeLabel);
        Theme.style_13(self.name);
        Theme.style_1(self.jobTitle);
       
        /** To hide margin in tableView **/
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);

        /** Add cells to the tableView **/
        let dict:NSDictionary = ["MoreTableViewCell":"MoreCell", "BaseTableViewCell":"cell" ];
         adapter = OptionsTableAdapter(viewController: self, tableView: tableView, registerMultipleNibsAndIdenfifers: dict);
    }
    


    
}
