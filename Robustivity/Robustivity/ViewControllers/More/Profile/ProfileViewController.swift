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

class ProfileViewController: BaseViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var profileHeader: UIView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileTableView: UITableView!
    @IBOutlet var profileName: RBLabel!
    @IBOutlet var profileJobTitle: RBLabel!
    @IBOutlet var profileUploadImage: UIButton!
    var imagePicker = UIImagePickerController()

    /*
    Declare variables.
    adapter: the adapter responsible for displaying cells in the table view.
    myProfile: checks whether this is the current user profile or another user profile.
    profileEditable: checks whether the profile is in edit mode or not.
    */
    var adapter:ProfileAdapter!
    var myProfile:Bool?
    var profileEditable:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        Create an instance of the adapter, and set it to the current adapter.
        Set the values of "myProfile" and "profileEditable" in the adapter, to the current values of "myProfile" and "profileEditable".
        */
        
        adapter = ProfileAdapter(viewController: self, tableView: profileTableView, registerCellWithNib:"ProfileTableViewCell", withIdentifier: "profileCellID")
        adapter.myProfile = myProfile
        adapter.profileEditable = profileEditable
        adapter.reloadItems()
        
        setupView()
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
        Setup the layout of the view to start below the navigation bar.
        */
        edgesForExtendedLayout = .None
        
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
                self.profileUploadImage.hidden = false
            }
        } else {
            self.navigationItem.title = "Islam"
        }
        
        /*
        If the profile is not in edit mode or this is not my profile, then display a close button "X" at the top left of the navigation bar that dismisses the view.
        */
        if !profileEditable || !myProfile! {
            let dismissProfileButton : UIBarButtonItem = UIBarButtonItem(title: "X", style: .Plain, target: self, action: "dismissProfileView")
            
            navigationItem.leftBarButtonItem = dismissProfileButton
            
            /*
            Author: Abdelrahman Sakr
            Hide the profile upload image if the profile is no longer editable
            */
            self.profileUploadImage.hidden = true
        }
        
        adapter.myProfile = myProfile
        adapter.profileEditable = profileEditable
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
        
        profileImage.image = UIImage(named: "Stroke 751 + Stroke 752.png")
        profileName.text = "Islam Abdelraouf"
        profileJobTitle.text = "Mobile Project Manager"
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
        self.adapter.profileEditparameters = NSMutableDictionary()
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
        self.view.endEditing(true)
        self.adapter.updateDataFromEditMode()
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
    Author: Abdelrahman Sakr
    This method opens the iPhone's photo library to allow the user to choose a photo to upload
    */
    @IBAction func btnClicked(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            print("Button capture")
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    /*
    Author: Abdelrahman Sakr
    Choose the picture from the photo library, then start uploading it using the API request
    */
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
            // Create message overlay
            let alert = UIAlertController(title: nil, message: "Updating Image...", preferredStyle: .Alert)
            alert.view.tintColor = UIColor.blackColor()
            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            loadingIndicator.startAnimating();
            
            // Present message overlay "Upadting Image..."
            alert.view.addSubview(loadingIndicator)
            self.presentViewController(alert, animated: true, completion: nil)
            
            // Update image API request
            API.putMultipart(APIRoutes.USER_EDIT, parameters: ["user[profile_picture]" : image]) { (Bool, AnyObject) -> () in
                
                // Remove overlay when request finishes
                self.dismissViewControllerAnimated(false, completion: nil)
                
                // Call setup view to refresh the data
                self.setupView()
            }
        })
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
