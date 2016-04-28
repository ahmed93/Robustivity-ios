//
//  DirectoryAdapter.swift
//  Robustivity
//
//  Created by MacBook Pro on 3/28/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
class DirectoryAdapter: BaseTableAdapter {
    
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        // any extra stuff to be done
    }
    
    
    func fetchItems() {
        
        if tableItems.count == 0 {
            API.get(APIRoutes.USER_STATUS, callback: { (success, response) in
                if(success){
                    
                    //map the json object to the model and save them
                    let inOffice = Mapper<User>().mapArray(response["in_office"])
                    let outOffice = Mapper<User>().mapArray(response["left_office"])
                    let onVacation = Mapper<User>().mapArray(response["on_vacation"])
                   
                
                    self.tableItems.addObject(inOffice!)
                    self.tableItems.addObject(outOffice!)
                    self.tableItems.addObject(onVacation!)
                    for user in inOffice! {
                   
                        self.saveNewTask(user)
                    }
                    for user in outOffice! {
                        
                        self.saveNewTask(user)
                    }
                    for user in onVacation! {
                        
                        self.saveNewTask(user)
                    }
                    
                    
                }
               
                 self.tableView.reloadData()
                 print(self.tableItems.count)
            })
            self.tableItems = ListModel()
        
            
        }

    }
    
    //save new array of new users on disk using realm
    func saveNewTask(ArrayOfUsers: User) {
        let realm = try! Realm()
        
        
        //check if is present or not
        for user in    realm.objects(User) {
            if user.userId == ArrayOfUsers.userId{
                return
            }
        }
        try! realm.write {
            realm.add(ArrayOfUsers)
        }
    }
    
  
   
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableItems.count
    }
   func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0
        {return "  In Office"}
        if section == 1{
        return "  Out of Office"}
        else{
        return " On Vacation"
        }
    }
    
    

     func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
        
        
        let label : UILabel = UILabel()
        if section == 0{
            label.text = "  In Office"
            label.font = UIFont.boldSystemFontOfSize(20)
            label.textColor = Theme.greenColor()
        } else if section == 1{
            
            label.text = "  Out of Office"
            label.font = UIFont.boldSystemFontOfSize(20)
            label.textColor = Theme.lighterBlackColor()
        }
        else{
            label.text = "  On Vacation"
            label.font = UIFont.boldSystemFontOfSize(20)
            label.textColor = Theme.blueColor();
            
        }
        return label
    }
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
       
        return (tableItems.objectAtIndex(section)!).count
   
    }
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0;
    }
    
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
      
        let _DirectoryCell = cell as? DirectoryCell

        let w =  tableItems.objectAtIndex(indexPath.section)
        let users = w?.objectAtIndex(indexPath.row) as! User
         _DirectoryCell?.userName.text = users.userFirstName + " " + users.userLastName
        _DirectoryCell?.userTitle.text = users.userTitle
      
        
      let url = NSURL(string: "http://hr.staging.rails.robustastudio.com" + users.userProfilePictureNotificationURL)
     
        
        
        
        _DirectoryCell?.userImage.sd_setImageWithURL(url)
        let imageSize = 50 as CGFloat
        _DirectoryCell?.userImage.layer.cornerRadius = imageSize / 2.0
        _DirectoryCell?.userImage.clipsToBounds = true
        
   
     }
    

    
}
