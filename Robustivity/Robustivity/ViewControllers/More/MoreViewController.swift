//
//  MoreViewController.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/20/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController {


    @IBOutlet weak var jobTitle: UILabel!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var profileMore: UIView!
    @IBOutlet weak var tableView: UITableView!
    var adapter:OptionsTableAdapter!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("MoreViewController", owner: self, options: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "More";
        self.navigationItem.title = "More";

        setProfileMore();
    }
    
    func setProfileMore(){
        self.profileMore.backgroundColor = Theme.getColor(Color.lightGray);
      //  self.avatar.image = UIImage (named:"/Assets.xcassets/islam.png");

        self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
        self.avatar.clipsToBounds = true;
        
        adapter = OptionsTableAdapter(viewController: self, tableView: tableView, registerCellWithNib:"MoreTableViewCell", withIdentifier: "MoreCell");
    //    adapter.
        
    
    }
    


    
}
