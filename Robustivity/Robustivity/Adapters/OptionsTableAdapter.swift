//
//  OptionsTableAdapter.swift
//  Robustivity
//
//  Created by  Created by Mayar ElMohr, Salma Amr, Nouran Mamdouh on 1/4/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit


class OptionsTableAdapter: BaseTableAdapter {
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
 
    
    override func configureViaMultipleIdentifiers(indexPath:NSIndexPath)->UITableViewCell? {
        let optionsCell = tableView.dequeueReusableCellWithIdentifier("MoreCell", forIndexPath: indexPath) as? MoreTableViewCell
             Theme.style_13((optionsCell?.label)!);
        
        let logOutCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as?BaseTableViewCell
        Theme.redColor();
        
        switch(indexPath.section){
        case 0:
            switch(indexPath.row)
            {
            case 0: optionsCell?.label.text = "My Attendance Log";
            optionsCell?.imgView.image? = UIImage(named:"Group4")!
            return optionsCell
            case 1: optionsCell?.label.text = "My Projects"
            optionsCell?.imgView.image? = UIImage(named:"Group 7")!
            return optionsCell
            default:()
            }
        case 1: optionsCell?.label.text = "Directory";
        optionsCell?.imgView.image? = UIImage(named:"Stroke 749 + Stroke 750")!
        return optionsCell
        case 2:
            switch(indexPath.row){
            case 0: optionsCell?.label.text = "Send Excuse";
            optionsCell?.imgView.image? = UIImage(named:"Group1")!
            return optionsCell
            case 1: optionsCell?.label.text = "Ping"
            optionsCell?.imgView.image? = UIImage(named:"Group3")!
            return optionsCell
            case 2: optionsCell?.label.text = "Reserve Meeting Room"
            optionsCell?.imgView.image? = UIImage(named:"Stroke 998 + Stroke 999")!
            return optionsCell
            default:()
                
            }
        case 3: optionsCell?.label.text = "Robustivity tools"
        optionsCell?.imgView.image? = UIImage(named:"Group2")!
        return optionsCell
            
        case 4: logOutCell?.label.text = "Log Out"
        logOutCell?.label.textColor = Theme.redColor();
        return logOutCell
        default:()
    }
        
        return nil;
        
}

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var x = 0;
        switch(section){
        case 0: x = 2
        case 2: x = 3
        default: x = 1
    
        }
        return x;
    }
    
    
    
    
    
    
    
}
