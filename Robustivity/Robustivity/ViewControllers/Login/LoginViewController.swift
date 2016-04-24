//
//  LoginViewController.swift
//  Robustivity
//
//  Created by Abdelrahman Sakr on 4/1/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import Google

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = "714551560486-88duhjqa2lkr57vbubu8e5faikmv5h4a.apps.googleusercontent.com"
        //selecting my scopes
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.login")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.me")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if let err = error {
            print(error)
        }
        else {
            print("######################")
            print(GIDSignIn.sharedInstance().currentUser.userID)

            print(GIDSignIn.sharedInstance().currentUser.authentication)

            print(GIDSignIn.sharedInstance().currentUser.profile.name)

            print(GIDSignIn.sharedInstance().currentUser.profile.givenName)

            print(GIDSignIn.sharedInstance().currentUser.profile.givenName)
            


            
            print("######################")

            performSegueWithIdentifier("LoginSegue", sender: self)
        }
    }
    
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        
    }
    
}
