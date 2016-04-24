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
            
            print(GIDSignIn.sharedInstance().currentUser.profile.name)
            
            print(GIDSignIn.sharedInstance().currentUser.profile.email)
            
            print(GIDSignIn.sharedInstance().currentUser.profile.givenName)
            
            print(GIDSignIn.sharedInstance().currentUser.profile.familyName)
            
            print(GIDSignIn.sharedInstance().currentUser.profile.imageURLWithDimension(3))
            
            
            print(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)

            print(GIDSignIn.sharedInstance().currentUser.authentication.refreshToken)

            print(GIDSignIn.sharedInstance().currentUser.authentication.accessTokenExpirationDate)
            
            print(GIDSignIn.sharedInstance().currentUser.authentication.idToken)


            print(GIDSignIn.sharedInstance().currentUser.profile.givenName)

            
//             let params = ["info": ["name": GIDSignIn.sharedInstance().currentUser.profile.name,"email": GIDSignIn.sharedInstance().currentUser.profile.email,"first_name": GIDSignIn.sharedInstance().currentUser.profile.givenName,"last_name": GIDSignIn.sharedInstance().currentUser.profile.familyName,"image": eGIDSignIn.sharedInstance().currentUser.profile.imageURLWithDimension(3)],"credentials": ["token": GIDSignIn.sharedInstance().currentUser.authentication.accessToken,"refresh_token": GIDSignIn.sharedInstance().currentUser.authentication.refreshToken,"expires_at": GIDSignIn.sharedInstance().currentUser.authentication.accessTokenExpirationDate,"expires": true]]
            
            
            let params = ["info": ["name": "iOS GUC","email": "ios.guc@robustastudio.com","first_name": "iOS","last_name": "GUC","image": "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50"],"credentials": ["token": "ya29..wgIeIQKaw-l6cSTDhwWJJkdvlt2CKoT3I8Ksre8uAPsEmlyPwlqlATNqUOGoknPZkg","refresh_token": "1/lWxeiqRLHwewAg5bHPGeKhjxuiGiEn2O3noifR3SBMUMEudVrK5jSpoR30zcRFq6","expires_at": 1460484463,"expires": true]]
            
            
            print("######################")
            print(params)

            Alamofire.request(Alamofire.Method.POST, APIRoutes.TOKEN_CREATE, headers: nil, parameters: params)
                .responseJSON { response in
                    print (response)
            }

//          API.post(APIRoutes.TOKEN_CREATE, parameters: params, callback: { (success, response) -> () in
//            print (response)
//            
//          })


            
            print("######################")

            performSegueWithIdentifier("LoginSegue", sender: self)
        }
    }
    
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        
    }
    
}
