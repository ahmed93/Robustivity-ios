//
//  ProfileAdapter.swift
//  Robustivity
//
//  Created by Nariman El-Samadoni AND Abdelrahman Sakr on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class ProfileAdapter: BaseTableAdapter, UITextFieldDelegate {
    
    /*
    Declare variables.
    myProfile: checks whether this is the current user profile or another user profile.
    profileEditable: checks whether the profile is in edit mode or not.
    */
    var myProfile:Bool?
    var profileEditable:Bool?
    var profileEditparameters:NSMutableDictionary?
    var user:User?
    var activeField: UITextField?
    
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        registerForKeyboardNotifications()
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
                    cell?.cellContent.text = userProfileData.userMobileNumber
            
                    /*
                    If this is my profile and it is in edit mode, then set the text field to be editable with the suitable placeholder text.
                    Else if it is not my profile (other user profile), then display the call button and attach to it the action method that will be called when it is clicked.
                    */
                    if myProfile! && profileEditable! {
                        cell?.cellContent.enabled = true
                        cell?.cellContent.attributedPlaceholder = NSAttributedString(string: "Enter your phone...", attributes: placeholderAttributes)
                        cell?.cellContent.tag = 1
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
                    if !myProfile! {
                        cell?.cellButton.setImage(mailImageBlue, forState: UIControlState.Normal)
                        cell?.cellButton?.addTarget(self.viewController, action: "userSendMailButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
                    }
            
            
            case 2: cell?.cellTitle.text = "Address"
                    cell?.cellContent.text = userProfileData.userAddress

                    /*
                    If this is my profile and it is in edit mode, then set the text field to be editable with the suitable placeholder text.
                    Else if it is not my profile (other user profile), then remove existing button.
                    */
                    if myProfile! && profileEditable! {
                        cell?.cellContent.enabled = true
                        cell?.cellContent.attributedPlaceholder = NSAttributedString(string: "Enter your address...", attributes: placeholderAttributes)
                        cell?.cellContent.tag = 2
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

    /*
    Author: Abdelrahman Sakr
    This delegate method is called whenever the textfield has ended editing
    */
    func textFieldDidEndEditing(textField: UITextField) {
        
        /*
        Switch case to know which textfield has ended editing.
        case 1 is the mobile number textfield
        case 2 is the address textfield
        Then it appends the current value of the textfield to its corresponding key in the dictionary
        */
        let user:User = (self.viewController as! ProfileViewController).user
        activeField = nil
        
        switch textField.tag {
        case 1:
            profileEditparameters?.setValue(textField.text!, forKey: "user[mobile_number]")
            user.realm?.beginWrite()
            user.userMobileNumber = textField.text!
            try?user.realm?.commitWrite()
            
        case 2:
            profileEditparameters?.setValue(textField.text!, forKey: "user[address]")
            user.realm?.beginWrite()
            user.userAddress = textField.text!
            try?user.realm?.commitWrite()

        default: break
        }
    }
    
    /*
    Author: Abdelrahman Sakr
    Gets the values of the textfields, then make an API request out of it to update user's data
    */
    func updateDataFromEditMode() {
        // Set the profileEditable to false to end editing mode
        profileEditable = false
        
        // Convert the NSMutableDictionary to a dictionary of String : AnyObject to pass it as a parameter for the API methods
        var putParameters = [String : AnyObject]()
        for (key, value) in self.profileEditparameters! {
            putParameters[key as! String] = (value as! String)
        }
        
        let profileViewController:ProfileViewController = (self.viewController as! ProfileViewController)
        
        // Show "Updating Data..." message overlay
        profileViewController.presentMessageOverlay("Updating Data...")
        
        // Make the API request
        API.put(APIRoutes.USER_EDIT, parameters: putParameters) { (success, response) -> () in
            // Call the parent setupView to reload the data and end editing mode
            profileViewController.dismissViewControllerAnimated(false, completion: nil)
            profileViewController.setupView()
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 1 {
            // Create an `NSCharacterSet` set which includes everything *but* the digits
            let inverseSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
            
            // At every character in this "inverseSet" contained in the string,
            // split the string up into components which exclude the characters
            // in this inverse set
            let components = string.componentsSeparatedByCharactersInSet(inverseSet)
            
            // Rejoin these components
            let filtered = components.joinWithSeparator("")  // use join("", components) if you are using Swift 1.2
            
            // If the original string is equal to the filtered string, i.e. if no
            // inverse characters were present to be eliminated, the input is valid
            // and the statement returns true; else it returns false
            return string == filtered
        }
        
        return true
    }
    
    
    //MARK: Methods to handle shifting up the view when the keyboard is opened to allow editing
    /*
    Author: Abdelrahman Sakr
    */
    
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification)
    {
        //Need to calculate keyboard exact size due to Apple suggestions
        self.tableView.scrollEnabled = true
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.tableView.contentInset = contentInsets
        self.tableView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.viewController.view.frame
        aRect.size.height -= keyboardSize!.height
        if let _ = activeField
        {
            if (!CGRectContainsPoint(aRect, activeField!.frame.origin))
            {
                self.tableView.scrollRectToVisible(activeField!.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        //Once keyboard disappears, restore original positions
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.tableView.contentInset = contentInsets
        self.tableView.scrollIndicatorInsets = contentInsets
        self.viewController.view.endEditing(true)
        self.tableView.scrollEnabled = false
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        activeField = textField
    }

}
