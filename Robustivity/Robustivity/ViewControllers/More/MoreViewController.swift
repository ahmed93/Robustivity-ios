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
    let preferences = NSUserDefaults.standardUserDefaults()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("MoreViewController", owner: self, options: nil)
    }
    
    
    override func viewDidLoad() {
        self.wantsUserCheckInStatus = true
        super.viewDidLoad()
        self.title = "More";
        self.navigationItem.title = "More";
        
        initMore();
    }
    
    /*
    The Method styles the profile UIView and intializes the adapter 
    to fill the table customized cells.
    
    Edited by: Mayar ElMohr, Salma Amr, Nouran Mamdouh on 3/31/16.
    */
    
    func initMore(){
        
        /* set username and job title from shared preference */
        let userFirstName = self.preferences.objectForKey("first_name") as? String
        let userLastName = self.preferences.objectForKey("last_name") as? String
        let userJobTitle = self.preferences.objectForKey("title") as? String
        if(userFirstName != nil){
            self.name.text = userFirstName!
        }
        if(userLastName != nil){
            self.name.text! += " " + userLastName!
        }
        if(userJobTitle != nil){
            self.jobTitle.text = userJobTitle!
        }
        else {
            self.jobTitle.text = "No Title"
        }

        
        /** Adding Call Button **/
        let call = UIBarButtonItem(image: UIImage(named: "call_white"), style: .Plain, target: self, action: NSSelectorFromString("callView"))
        navigationItem.rightBarButtonItem = call
        
        /** Setting backround color **/
        self.profileMore.backgroundColor = Theme.getColor(Color.lightGray);
        
        /** Creating a shadow after the UIView **/
        
        self.profileMore.clipsToBounds = false;
        self.profileMore.layer.shadowColor = Theme.getColor(Color.black).CGColor;
        self.profileMore.layer.shadowOffset = CGSizeMake(0,3);
        self.profileMore.layer.shadowOpacity = 0.5;
        
        
        /** a Rounded avatar **/
        if self.preferences.objectForKey("picture_url") != nil {
            let image_url = self.preferences.objectForKey("picture_url") as! String
            self.avatar.sd_setImageWithURL(NSURL(string:"http://hr.staging.rails.robustastudio.com" + image_url))
        }
        self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
        self.avatar.clipsToBounds = true;
        avatar.userInteractionEnabled = true
        avatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: NSSelectorFromString("showMyProfile")))
        
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
    
    
    
    /** This function is supposed to perform Calling functionality **/
    func callView(){
        presentViewController(UINavigationController(rootViewController: CallViewController()), animated: true, completion: nil)
    }
    
    
    func showMyProfile() {
        let profile = ProfileViewController()
        profile.myProfile = true
        
        presentViewController(UINavigationController(rootViewController: profile), animated: true, completion: nil)
    }
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        if keyPath == "checkedIn" {
            if NSUserDefaults.standardUserDefaults().boolForKey("checkedIn") {
                //                checkInStatusImageView.backgroundColor = Theme.greenColor()
            }else {
                //                checkInStatusImageView.backgroundColor = Theme.grayColor()
            }
        }
    }
    
}
