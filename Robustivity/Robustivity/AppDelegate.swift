//
//  AppDelegate.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import Google
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    var locationManager = CLLocationManager()
    var status = false
    //        let robustaRegin = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 29.999966133078818, longitude: 31.41594702178736), radius: 200, identifier: "Robusta")
    let robustaRegin = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 31.475328, longitude: 30.041010), radius: 200, identifier: "Robusta")
    
    let preferences = NSUserDefaults.standardUserDefaults()
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        startSignificantLocation()
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        startUpdatingLocation()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.allowsBackgroundLocationUpdates = true
        
        locationManager.requestAlwaysAuthorization()
        
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        // Configuring UserDefaults
        preferences.setInteger(21, forKey: "id")
        preferences.setObject("jihan.elmarakby@robustastudio.com", forKey: "email")
        preferences.setObject("Jihan", forKey: "first_name")
        preferences.setObject("Adel", forKey: "last_name")
        preferences.setObject("01060679458", forKey: "mobile_number")
        preferences.setObject("Yasmine compound, first settlement, new cairo", forKey: "address")
        preferences.setObject("Web Developer", forKey: "title")
        preferences.setObject("Ahmed Adel", forKey: "contact_person_name")
        preferences.setObject("01004467995", forKey: "contact_person_phone")
        preferences.setObject("Brother", forKey: "contact_person_relation")
        preferences.setObject("Yasmine compound, first settlement, new cairo", forKey: "contact_person_address")
        preferences.setObject("/uploads/users/21/profile_picture/profile_11874124_10153598278534343_481294197_n.jpg", forKey: "picture_url")
        preferences.setObject("/uploads/users/21/profile_picture/square_11874124_10153598278534343_481294197_n.jpg", forKey: "picture_square_url")
        preferences.setObject("/uploads/users/21/profile_picture/icon_11874124_10153598278534343_481294197_n.jpg", forKey: "picture_icon_url")
        preferences.setObject("/uploads/users/21/profile_picture/notifications_11874124_10153598278534343_481294197_n.jpg", forKey: "picture_notifications_url")
        preferences.setObject("Cairo", forKey: "city")
        preferences.setBool(status, forKey: "checkedIn")
        
        preferences.synchronize()
        
        ToggleManager.sharedInstance.fetchInProgressTask()
        
        return true
    }
    
    func application(application: UIApplication,
        openURL url: NSURL, options: [String: AnyObject]) -> Bool {
            return GIDSignIn.sharedInstance().handleURL(url,
                sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    
    func application(application: UIApplication,
        openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
            var options: [String: AnyObject] = [UIApplicationOpenURLOptionsSourceApplicationKey: sourceApplication!,
                UIApplicationOpenURLOptionsAnnotationKey: annotation!]
            return GIDSignIn.sharedInstance().handleURL(url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                
                // ...
            } else {
                print("\(error.localizedDescription)")
            }
    }
    
}

extension AppDelegate: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedWhenInUse:
            break
        case .AuthorizedAlways:
            startUpdatingLocation()
            break
        case .NotDetermined:
            manager.requestAlwaysAuthorization()
        case .Restricted, .Denied:
            let alertController = UIAlertController(
                title: "Background Location Access Disabled",
                message: "In order to be notified about adorable kittens near you, please open this app's settings and set location access to 'Always'.",
                preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            alertController.addAction(openAction)
            
            window?.rootViewController!.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        status = preferences.boolForKey("checkedIn")
        if robustaRegin.containsCoordinate((locations.last?.coordinate)!) {
            if !status {
                print("checkedIn")
                checkIn()
            }
        }else {
            if status {
                print("checkedOut")
                checkOut()
            }
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        checkIn()
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        checkOut()
    }
    
    
    
    
    func checkIn() {
        status = preferences.boolForKey("checkedIn")
        if !status {
            API.put("working_days/checkin", parameters:["":""]) { (success:Bool, response: AnyObject) -> () in
                if success {
                    print("checkedIn_wwww")
                    self.preferences.setObject(NSDate(), forKey: "checkInDate")
                    self.preferences.setBool(true, forKey: "checkedIn")
                    self.preferences.synchronize()
                    
                }
                print(success)
            }
        }
    }
    
    func checkOut() {
        status = preferences.boolForKey("checkedIn")
        if status {
            API.put("working_days/checkout", parameters: ["":""]) { (success, response) -> () in
                if success {
                    print("checkedOut_wwww")
                    self.preferences.setObject(NSDate(), forKey: "checkInDate")                    
                    self.preferences.setBool(false, forKey: "checkedIn")
                    self.preferences.synchronize()
                }
                print(success)
            }
        }
    }
    
    func startSignificantLocation() {
        locationManager.distanceFilter = 100
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            locationManager.stopUpdatingLocation()
            locationManager.startMonitoringForRegion(robustaRegin)
            locationManager.startMonitoringSignificantLocationChanges()
        }else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func startUpdatingLocation() {
        locationManager.distanceFilter = 10
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopMonitoringForRegion(robustaRegin)
            locationManager.stopMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
        }else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}

