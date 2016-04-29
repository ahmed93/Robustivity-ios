//
//  ProjectInfoAdapter.swift
//  Robustivity
//
//  Created by Abanoub Aziz on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class ProjectInfoAdapter: BaseTableAdapter {
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // any extra stuff to be done
    }
    
    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
    }

    func saveNewProject(project: Project) {
        let realm = try! Realm()
        let savedProjects = realm.objects(Project)
        for checkProject in savedProjects {
            if checkProject.projectId == project.projectId{ return
            }
        }
        try! realm.write { realm.add(project)}
    }


    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let projectInfoCell = cell as? ProjectMemberCell
        let currentCellData = tableItems.objectAtIndex(indexPath.row) as! NSDictionary
        switch(currentCellData.objectForKey("type") as! String) {
        case "1":
            projectInfoCell?.nameLabel.text = currentCellData.objectForKey("name") as? String
            projectInfoCell?.positionLabel.text = currentCellData.objectForKey("role") as? String
            let avatar:String = (currentCellData.objectForKey("avatar") as? String)!
            if(avatar == ""){
                projectInfoCell?.profileImageView.image = UIImage(named: "Stroke 751 + Stroke 752")
            }else{
                projectInfoCell?.profileImageView.sd_setImageWithURL(NSURL(string: "http://hr.staging.rails.robustastudio.com" + avatar))
                projectInfoCell?.profileImageView.layer.cornerRadius = (projectInfoCell?.profileImageView.frame.size.width)! / 2
                projectInfoCell?.profileImageView.clipsToBounds = true
            }
        case "2":
            projectInfoCell?.nameLabel.text = currentCellData.objectForKey("name") as? String
            projectInfoCell?.positionLabel.text = currentCellData.objectForKey("role") as? String
            let telephoneNumber:String = (currentCellData.objectForKey("telephoneNumber")
                as? String)!
            if(telephoneNumber != ""){
                projectInfoCell?.profileImageView.image = UIImage(named: "Stroke 751 + Stroke 752")
                let image = UIImage(named: "call_blue")
                let callButton = UIButton(type: UIButtonType.Custom) as UIButton
                callButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                callButton.setImage(image, forState: .Normal)
                let x = (projectInfoCell?.contentView.bounds.maxX   )! - 34
                let y = (projectInfoCell?.contentView.center.y)!
                callButton.center = CGPoint(x:  x, y: y)
                callButton.translatesAutoresizingMaskIntoConstraints = true
                callButton.addTarget(self.viewController as? ProjectInfoViewController, action: "callSponser:", forControlEvents: .TouchUpInside)
                projectInfoCell!.addSubview(callButton)
            }
        case "3":
            let billable:Bool = currentCellData.objectForKey("billable") as! Bool
            if(billable){
                projectInfoCell?.nameLabel.text = currentCellData.objectForKey("billAmount") as? String
                projectInfoCell?.positionLabel.text =  "Billable"
            }else if(billable){
                projectInfoCell?.nameLabel.text = ""
                projectInfoCell?.positionLabel.text =  "Not Billable"
            }else{
                projectInfoCell?.nameLabel.text = ""
                projectInfoCell?.positionLabel.text =  "Not Defined"
            }
            projectInfoCell?.profileImageView.image = UIImage(named: "Stroke 2406 + Stroke 2407 + Stroke 2408")
        default: break;
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(57)
    }
    
    
    
}
