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
                    
                    //map the jason object to the model and save them
                    let inOffice = Mapper<TaskModel>().mapArray(response["in_office"])
                    let outOffice = Mapper<TaskModel>().mapArray(response["left_office"])
                    let onVacation = Mapper<TaskModel>().mapArray(response["on_vacation"])

                    for user in inOffice! {
                        self.tableItems.addObject(user)
                        
                    }
                    for user in outOffice! {
                        self.tableItems.addObject(user)
                        
                    }
                    for user in onVacation! {
                        self.tableItems.addObject(user)
                        
                    }
                    
                }
            })
            //tableItems = ListModel()
             tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, 2)), withRowAnimation: .Bottom)
        }

        
        
     /*   tableItems.addObject([["name":"Ahmed Abousafy","position":"Account Manager","imagename":"Stroke 751 + Stroke 752"],["name":"Islam Abdelraouf","position":"Project Manager","imagename":"Stroke 751 + Stroke 752"]])
        tableItems.addObject([["name":"Ahmed Abousafy","position":"Account Manager","imagename":"Stroke 751 + Stroke 752"],["name":"Islam Abdelraouf","position":"Project Manager","imagename":"Stroke 751 + Stroke 752"],["name":"Ahmed Abousafy","position":"Account Manager","imagename":"Stroke 751 + Stroke 752"],["name":"Islam Abdelraouf","position":"Project Manager","imagename":"Stroke 751 + Stroke 752"]])
        tableItems.addObject([["name":"Ahmed Abousafy","position":"Account Manager","imagename":"Stroke 751 + Stroke 752"],["name":"Islam Abdelraouf","position":"Project Manager","imagename":"Stroke 751 + Stroke 752"],["name":"Ahmed Abousafy","position":"Account Manager","imagename":"Stroke 751 + Stroke 752"],["name":"Islam Abdelraouf","position":"Project Manager","imagename":"Stroke 751 + Stroke 752"]])*/
        tableView.reloadData()
    }
    
    func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{
        
        
        let scale = CGFloat(max(size.width/image.size.width,
            size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale;
        
        let rr:CGRect = CGRectMake( 0, 0, width, height);
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.drawInRect(rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
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
        if section == 0 {
            // [TODO] replace it by the number of items IN PROGRESS returned from the server.
            //if selectedSegmentIndex == 0 {
            //return 3
            //}
            return tableItems.count
        }
        
        // Items Done Count.
        // [TODO] replace it by the number of items DONE returned from the server.
        //if selectedSegmentIndex == 0 {
        //return 3
        //}
        return tableItems.count
    }
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0;
    }
    
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
      //  let _cell = cell as? DirectoryCell
     /*   let _DirectoryCell = cell as? DirectoryCell
        
        let task = tableItems.objectAtIndex(indexPath.row) as! TaskModel
        _DirectoryCell?.userName.text = task.taskName
        _DirectoryCell?.userTitle.text = task.taskDescription*/
        
    /*
         let w =  tableItems.objectAtIndex(indexPath.section)
        let x = w?.objectAtIndex(indexPath.row).objectForKey("first_name" + "last_name")
        let y = w?.objectAtIndex(indexPath.row).objectForKey("title")
        let z = w?.objectAtIndex(indexPath.row).objectForKey("imagename")
        _cell?.userName.text = x as! String
        _cell?.userTitle.text = y as! String
        
     
        let image = UIImage(named: z as! String)
        let newImage = resizeImage(image!, toTheSize: CGSizeMake(70, 70))
        var cellImageLayer: CALayer?  = _cell?.userImage.layer
        cellImageLayer!.cornerRadius = cellImageLayer!.frame.size.width / 2
        cellImageLayer!.masksToBounds = true
        _cell?.userImage.image = newImage
        */
     }
    
    
    
   

    
    
}
