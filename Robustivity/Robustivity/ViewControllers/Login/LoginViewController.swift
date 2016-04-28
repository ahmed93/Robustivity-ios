//
//  LoginViewController.swift
//  Robustivity
//
//  Created by Abdelrahman Sakr on 4/1/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import Google
import Alamofire


class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    var access_token = ""
    var expires_in = ""
    var refresh_token = ""
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
    

           
             let params = ["info": ["name": GIDSignIn.sharedInstance().currentUser.profile.name,"email": GIDSignIn.sharedInstance().currentUser.profile.email,"first_name": GIDSignIn.sharedInstance().currentUser.profile.givenName,"last_name": GIDSignIn.sharedInstance().currentUser.profile.familyName,"image": GIDSignIn.sharedInstance().currentUser.profile.imageURLWithDimension(3).absoluteString],"credentials": ["token": GIDSignIn.sharedInstance().currentUser.authentication.accessToken,"refresh_token": GIDSignIn.sharedInstance().currentUser.authentication.refreshToken,"expires_at": GIDSignIn.sharedInstance().currentUser.authentication.accessTokenExpirationDate.timeIntervalSince1970,"expires": true]]
            
            
            Alamofire.request(.POST, APIRoutes.TOKEN_CREATE, headers: nil, parameters: params, encoding:.JSON)
                .responseJSON { response in switch response.result {
                case .Success(let JSON):
                    print("Success with JSON: \(JSON)")
                    let response = JSON as! NSDictionary
                    if ((response.objectForKey("access_token")) != nil){
                        // the key exists in the dictionary
                   
                    self.access_token = response.objectForKey("access_token")! as! String
                    self.expires_in = response.objectForKey("expires_in")! as! String
                    self.refresh_token = response.objectForKey("refresh_token")! as! String
                        }
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    }}
                    
                    if(self.access_token != ""){
                          performSegueWithIdentifier("LoginSegue", sender: self)
                    }
            

            
            }
   
    }
  

    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        
    }
    
}
