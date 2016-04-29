//
//  ProfileAdapter.swift
//  Robustivity
//
//  Created by Nariman El-Samadoni AND Abdelrahman Sakr on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper

class ProfileAdapter: BaseTableAdapter {
    
    /*
    Declare variables.
    myProfile: checks whether this is the current user profile or another user profile.
    profileEditable: checks whether the profile is in edit mode or not.
    */
    var myProfile:Bool?
    var profileEditable:Bool?
    var user:User?
    
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
    }
    
    /*
    Fetch items that will be added to the tableview cells.
    */
    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
        
        /*
        If the user is not nil then add him to the table items
        */
        if (user != nil){
            tableItems.addObject(user!)
        }
        
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let cell = cell as? ProfileTableViewCell
        
        /*
        Get the data of the user that will be added.
        */
        let userProfileData = tableItems.objectAtIndex(indexPath.section) as! User
        
        /*
        Set common style for cells in the table view.
        */
        cell?.selectionStyle = .None
        cell?.cellTitle.labelType = 2000
        cell?.cellContent.borderStyle = .None
        cell?.cellContent.enabled = false
        cell?.cellContent.font = UIFont(name: "MyriadPro-Regular", size: 16)
        let placeholderAttributes = [NSFontAttributeName : UIFont(name: "MyriadPro-Regular", size: 16)!]
        
        /*
        Fetch images of the call button and send email that will be added in the cell.
        */
        let callImageBlue = UIImage(named: "call_blue.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let mailImageBlue = UIImage(named: "Stroke 1264 + Stroke 1265.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let callImageRed = UIImage(named: "call_red.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        /*
        Switch case to handle displaying each cell differently.
        Case 0: User's Phone Cell
        Case 1: User's E-mail Cell
        Case 2: User's Address Cell
        Case 3: User's Emergency Cell
        */
        switch indexPath.row
        {
            case 0: cell?.cellTitle.text = "Phone"
                    cell?.cellContent.text = userProfileData.userMobileNumber
            
                    /*
                    If this is my profile and it is in edit mode, then set the text field to be editable with the suitable placeholder text.
                    Else if it is not my profile (other user profile), then display the call button and attach to it the action method that will be called when it is clicked.
                    */
                    if myProfile! && profileEditable! {
                        cell?.cellContent.enabled = true
                        cell?.cellContent.attributedPlaceholder = NSAttributedString(string: "Enter your phone...", attributes: placeholderAttributes)
                    } else if !myProfile! {
                        cell?.cellButton?.setImage(callImageBlue, forState: UIControlState.Normal)
                        cell?.cellButton?.addTarget(self.viewController, action: "userCallButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
                    }
            
            
            case 1: cell?.cellTitle.text = "E-mail"
                    cell?.cellContent.text = userProfileData.userEmail
            
                    /*
                    If this is my profile and it is in edit mode, then set the text field to be editable with the suitable placeholder text.
                    Else if it is not my profile (other user profile), then display the message button and attach to it the action method that will be called when it is clicked.
                    */
                    if myProfile! && profileEditable! {
                        cell?.cellContent.enabled = true
                        cell?.cellContent.attributedPlaceholder = NSAttributedString(string: "Enter your email...", attributes: placeholderAttributes)
                    } else if !myProfile! {
                        cell?.cellButton.setImage(mailImageBlue, forState: UIControlState.Normal)
                        cell?.cellButton?.addTarget(self.viewController, action: "userSendMailButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
                    }
            
            
            case 2: cell?.cellTitle.text = "Address"
                    cell?.cellContent.text = userProfileData.userAddress + ". " + userProfileData.userCity

                    /*
                    If this is my profile and it is in edit mode, then set the text field to be editable with the suitable placeholder text.
                    Else if it is not my profile (other user profile), then remove existing button.
                    */
                    if myProfile! && profileEditable! {
                        cell?.cellContent.enabled = true
                        cell?.cellContent.attributedPlaceholder = NSAttributedString(string: "Enter your address...", attributes: placeholderAttributes)
                    } else if !myProfile! {
                        cell?.cellButton?.removeFromSuperview()
                    }
            
            case 3: cell?.cellTitle.text = "Emergency"
                    cell?.cellTitle.textColor = Theme.redColor()
            
                    /*
                    If the user contact emergency person name is not empty then display it in the cell.
                    Else, display "no emergency contact" and remove the call button.
                    */
                    if (userProfileData.userContactPersonName != "") {
                        cell?.cellContent.text = userProfileData.userContactPersonName
                        
                        /*
                        If this is not my profile (other user profile), then display the emergency call button and attach to it the action method that will be called when it is clicked.
                        */
                        if !myProfile! {
                            cell?.cellButton?.setImage(callImageRed, forState: UIControlState.Normal)
                            cell?.cellButton?.addTarget(self.viewController, action: "userEmergencyCallButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
                        }
                    } else {
                        cell?.cellContent.text = "no emergency contact"
                        cell?.cellButton?.removeFromSuperview()
                    }
            
                    /*
                    If the user contact emergency person relation is not empty then display it in the cell.
                    */
                    if (userProfileData.userContactPersonRelation != "") {
                        cell?.cellContent.text! += " (" + userProfileData.userContactPersonRelation + ")"
                    }
            
                    /*
                    Remove table separator from the last cell in the table.
                    */
                    cell?.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(tableView.bounds)/2.0, 0, CGRectGetWidth(tableView.bounds)/2.0)
            
            default: break
        }
    }
}
