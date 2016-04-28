//
//  ProfileViewController.swift
//  Robustivity
//
//  Created by Nariman El-Samadoni AND Abdelrahman Sakr on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//


/*
Anyone creating/pushing an instance of this controller (redirecting to this view) should create an instance of this controller first, then he/she MUST set the "myProfile" boolean variable by either "true" or "false".
"true": if this is the current user's profile.
"false": if this is another user's profile (a colleague/teammate).
*/

import UIKit
import ObjectMapper
import MessageUI
import RealmSwift

class ProfileViewController: BaseViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet var profileHeader: UIView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileTableView: UITableView!
    @IBOutlet var profileName: RBLabel!
    @IBOutlet var profileJobTitle: RBLabel!
    @IBOutlet var profileUploadImage: UIButton!
    
    /*
    Declare variables.
    adapter: the adapter responsible for displaying cells in the table view.
    myProfile: checks whether this is the current user profile or another user profile.
    profileEditable: checks whether the profile is in edit mode or not.
    */
    var adapter:ProfileAdapter!
    var myProfile:Bool?
    var profileEditable:Bool = false
    var user:User = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        Print the deafault.realm file path so that we can open it using the realm browser and see our database.
        */
        print("DB LOCATION IS \(Realm.Configuration.defaultConfiguration.path!)")
        
        /*
        Setup the layout of the view to start below the navigation bar.
        */
        edgesForExtendedLayout = .None
        
        /*
        If this is my profile then set the request URL to the API request of show My profile (GET).
        Else if this is not my profile (other user's profile), set the request URL to the API request of show user profile (GET)
        */
        var requestURL:String
        if (myProfile!) {
            requestURL = APIRoutes.USER_PROFILE;
        } else {
            requestURL = APIRoutes.USER_SHOW + "/2";
        }
        
        /*
        Send a GET request in order to fetch the user that his profile will be shown.
        */
        API.get(requestURL) { (success, response) -> () in
            if (success) {
                /*
                Map the user from the respone to our User model using Object Mapper
                */
                var userFromResponse = User()
                userFromResponse = Mapper<User>().map(response)!
                
                self.user = userFromResponse
                
                /*
                Save or update the fetched user in the database using Realm by calling a static method in the User model.
                */
                User.updateOrSaveUser(userFromResponse)
                
                
                /*
                Create an instance of the adapter, and set it to the current adapter.
                Set the values of "myProfile" and "profileEditable" in the adapter, to the current values of "myProfile" and "profileEditable".
                */
                self.adapter = ProfileAdapter(viewController: self, tableView: self.profileTableView, registerCellWithNib:"ProfileTableViewCell", withIdentifier: "profileCellID")
                self.adapter.myProfile = self.myProfile
                self.adapter.profileEditable = self.profileEditable
                self.adapter.user = self.user
                self.adapter.reloadItems()
                
                self.setupView()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setupView() {
        /*
        Create tap gesture and add it to the table view, so that when the user taps anywhere in the screen the keyboard is dismissed.
        */
        let profileViewTapScreenAnywhere : UITapGestureRecognizer  = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        profileTableView.addGestureRecognizer(profileViewTapScreenAnywhere)
        
        /*
        Calls customizeProfileHeader() method, that is described below.
        */
        customizeProfileHeader()
        
        /*
        Remove extra cells from the table view.
        */
        profileTableView.tableFooterView = UIView()
        
        /*
        If this is my profile, then display "Me" in the navigation bar.
        Add edit button to the top right of the navigation bar if it is not already in edit mode.
        If the profile is in edit mode, then show the upload image button under the profile image.
        If it is not my profile, then display the name of the user in the navigation bar.
        */
        if myProfile! {
            self.navigationItem.title = "Me"
            if !profileEditable {
                let profileEditButton : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "setEditMode")
                navigationItem.rightBarButtonItem = profileEditButton
            } else {
                profileUploadImage?.setImage(UIImage(named: "upload_image.png"), forState: UIControlState.Normal)
            }
        } else {
            self.navigationItem.title = user.userFirstName
        }
        
        /*
        If the profile is not in edit mode or this is not my profile, then display a close button "X" at the top left of the navigation bar that dismisses the view.
        */
        if !profileEditable || !myProfile! {
            let dismissProfileButton : UIBarButtonItem = UIBarButtonItem(title: "X", style: .Plain, target: self, action: "dismissProfileView")
            
            navigationItem.leftBarButtonItem = dismissProfileButton
        }
        
        adapter.myProfile = myProfile
        adapter.profileEditable = profileEditable
        adapter.user = self.user
        adapter.reloadItems()
    }
    
    /*
    Setup the view holding the image of the user, his/her name, and the job title.
    */
    func customizeProfileHeader() {
        profileHeader.backgroundColor = Theme.lightGrayColor()
        profileHeader.layer.shadowColor = UIColor.blackColor().CGColor
        profileHeader.layer.shadowOpacity = 1
        profileHeader.layer.shadowOffset = CGSizeZero
        profileHeader.layer.shadowRadius = 3
        
        profileName.text = user.userFirstName + " " + user.userLastName
        profileJobTitle.text = user.userTitle
        
        let imageURL = APIRoutes.URL + (user.userProfilePictureProfileURL)
        profileImage.sd_setImageWithURL(NSURL(string: imageURL))
        profileImage.layer.cornerRadius = profileImage.frame.width/2
    }
    
    /*
    Enable edit mode in the profile, and replace the existing "edit" button by "done" button, and the "X" button by the "Cancel" button.
    */
    func setEditMode() {
        let profileDoneButton :UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "updateDataFromEditMode")
        navigationItem.rightBarButtonItem = profileDoneButton
        
        let profileCancelButton :UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "disableEditMode")
        navigationItem.leftBarButtonItem = profileCancelButton
        
        profileEditable = true
        setupView()
    }
    
    /*
    Dismiss the profile view when clicking on the "X" button.
    */
    func dismissProfileView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    Update user data based on the data that he/she edited.
    */
    func updateDataFromEditMode() {
        profileEditable = false
        setupView()
        // Include here any logic needed to update the database with the new values
    }
    
    /*
    Disable the profile edit mode.
    */
    func disableEditMode() {
        profileEditable = false
        setupView()
    }
    
    /*
    Dismiss the keyboard that appears in edit mode when the user clicks anywhere on the screen.
    */
    func dismissKeyboard() {
        profileTableView.endEditing(true)
    }
    
    
    /*
    Function for making a phone call to the user when the call button is pressed
    */
    func userCallButtonPressed(sender:UIButton) {
        let phoneNumber = "tel://" + user.userMobileNumber
        let url:NSURL = NSURL(string: phoneNumber)!
        UIApplication.sharedApplication().openURL(url)
        
        print("===================================")
        print("Call button pressed to call \(phoneNumber)")
    }
    
    /*
    Function for making a phone call to the user emergency contact when the emergency call button is pressed
    */
    func userEmergencyCallButtonPressed(sender:UIButton) {
        let phoneNumber = "tel://" + user.userContactPersonPhone
        let url:NSURL = NSURL(string: phoneNumber)!
        UIApplication.sharedApplication().openURL(url)
        
        print("===================================")
        print("Emergency Call button pressed to call \(phoneNumber)")
    }
    
    /*
    Function for sending an email to the user when the send message button is pressed
    */
    func userSendMailButtonPressed(sender: UIButton) {
        print("===================================")
        print("Send Mail button pressed and recipient is \(user.userEmail)")
        
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        
        let recipient:String = user.userEmail
        mailComposeViewController.setToRecipients([recipient])
        
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    /*
    Function that shows an alert message if the email could not be sent
    */
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .Alert)
        
         self.presentViewController(sendMailErrorAlert, animated: true, completion:nil)
    }
    
    
    /*
    Implementing the MFMailComposeViewControllerDelegate delegate method which dismisses the mail composer view when the mail is sent.
    */
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
