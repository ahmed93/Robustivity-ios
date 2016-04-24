//
//  ProfileAdapter.swift
//  Robustivity
//
//  Created by Nariman El-Samadoni AND Abdelrahman Sakr on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class ProfileAdapter: BaseTableAdapter, UITextFieldDelegate {
    
    /*
    Declare variables.
    myProfile: checks whether this is the current user profile or another user profile.
    profileEditable: checks whether the profile is in edit mode or not.
    */
    var myProfile:Bool?
    var profileEditable:Bool?
    var profileEditparameters:NSMutableDictionary?
    
    
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
        tableItems.addObject([
            "Phone"       	:"0123456789",
            "E-mail"      	:"islam@robustastudio.com",
            "Address"      	:"Cairo, Egypt",
            "Emergency"  	:"Ahmed Abdelraouf (Brother)"
            ])
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
        let profileData = (tableItems.objectAtIndex(indexPath.section) as! NSDictionary)
        
        /*
        Set common style for cells in the table view.
        */
        cell?.selectionStyle = .None
        cell?.cellTitle.labelType = 2000
        cell?.cellContent.borderStyle = .None
        cell?.cellContent.enabled = false
        cell?.cellContent.font = UIFont(name: "MyriadPro-Regular", size: 16)
        cell?.cellContent.delegate = self
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
                    cell?.cellContent.text = profileData.objectForKey("Phone") as? String
            
                    /*
                    If this is my profile and it is in edit mode, then set the text field to be editable with the suitable placeholder text.
                    Else if it is not my profile (other user profile), then display the call button.
                    */
                    if myProfile! && profileEditable! {
                        cell?.cellContent.enabled = true
                        cell?.cellContent.font = UIFont(name: "MyriadPro-Regular", size: 16)
                        cell?.cellContent.attributedPlaceholder = NSAttributedString(string: "Enter your phone...", attributes: placeholderAttributes)
                        cell?.cellContent.tag = 1
                    } else if !myProfile! {
                        cell?.cellButton?.setImage(callImageBlue, forState: UIControlState.Normal)
                    }
            
            
            case 1: cell?.cellTitle.text = "E-mail"
                    cell?.cellContent.text = profileData.objectForKey("E-mail") as? String
            
                    /*
                    If this is my profile and it is in edit mode, then set the text field to be editable with the suitable placeholder text.
                    Else if it is not my profile (other user profile), then display the message button.
                    */
                    if myProfile! && profileEditable! {
                        cell?.cellContent.enabled = true
                        cell?.cellContent.font = UIFont(name: "MyriadPro-Regular", size: 16)
                        cell?.cellContent.attributedPlaceholder = NSAttributedString(string: "Enter your email...", attributes: placeholderAttributes)
                    } else if !myProfile! {
                        cell?.cellButton.setImage(mailImageBlue, forState: UIControlState.Normal)
                    }
            
            
            case 2: cell?.cellTitle.text = "Address"
                    cell?.cellContent.text = profileData.objectForKey("Address") as? String
            
                    /*
                    If this is my profile and it is in edit mode, then set the text field to be editable with the suitable placeholder text.
                    Else if it is not my profile (other user profile), then remove existing button.
                    */
                    if myProfile! && profileEditable! {
                        cell?.cellContent.enabled = true
                        cell?.cellContent.font = UIFont(name: "MyriadPro-Regular", size: 16)
                        cell?.cellContent.attributedPlaceholder = NSAttributedString(string: "Enter your address...", attributes: placeholderAttributes)
                        cell?.cellContent.tag = 2
                    } else if !myProfile! {
                        cell?.cellButton?.removeFromSuperview()
                    }
            
            case 3: cell?.cellTitle.text = "Emergency"
                    cell?.cellTitle.textColor = Theme.redColor()
                    cell?.cellContent.text = profileData.objectForKey("Emergency") as? String
            
                    /*
                    If this is not my profile (other user profile), then display the emergency call button.
                    */
                    if !myProfile! {
                        cell?.cellButton?.setImage(callImageRed, forState: UIControlState.Normal)
                    }
            
                    /*
                    Remove table separator from the last cell in the table.
                    */
                    cell?.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(tableView.bounds)/2.0, 0, CGRectGetWidth(tableView.bounds)/2.0)
            
            default: break
        }
    }

    
    func textFieldDidEndEditing(textField: UITextField) {
        switch textField.tag {
        case 1:
            profileEditparameters?.setValue(textField.text!, forKey: "user[mobile_number]")
            
        case 2:
            profileEditparameters?.setValue(textField.text!, forKey: "user[address]")

        default: break
        }
    }
    
    func updateDataFromEditMode() {
        profileEditable = false

        var putParameters = [String : AnyObject]()
        for (key, value) in self.profileEditparameters! {
            putParameters[key as! String] = (value as! String)
        }
        
        API.put(APIRoutes.USER_EDIT, parameters: putParameters) { (success, response) -> () in
            (self.viewController as! ProfileViewController).setupView()
        }
    }

}
