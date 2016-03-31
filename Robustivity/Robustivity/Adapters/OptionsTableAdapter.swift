//
//  ProjectsListAdapter.swift
//  Robustivity
//
//  Created by Mariam Mohamed Fawzy on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit


class OptionsTableAdapter: BaseTableAdapter {
    
    


    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
 
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let optionsCell = cell as? MoreTableViewCell
        Theme.style_13((optionsCell?.label)! );

        switch(indexPath.section){
        case 0:
            switch(indexPath.row)
            {
               case 0: optionsCell?.label.text = "My Attendance Log";
        optionsCell?.imgView.image? = UIImage(named:"Group4")!
                case 1: optionsCell?.label.text = "My Projects"
                optionsCell?.imgView.image? = UIImage(named:"Group4")!

                default:()
            }
        case 1: optionsCell?.label.text = "Directory";
        case 2:
            switch(indexPath.row){
            case 0: optionsCell?.label.text = "Send Excuse";
            case 1: optionsCell?.label.text = "Ping"
            case 2: optionsCell?.label.text = "Reserve Meeting Room"
            default:()

            }
        case 3: optionsCell?.label.text = "Robustivity tools"
        default:()

      
            
            }
            
 

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
