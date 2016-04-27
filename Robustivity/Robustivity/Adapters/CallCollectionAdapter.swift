//
//  CallCollectionAdapter.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 4/2/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

//created by Menna ElKharbotly


import UIKit
import ObjectMapper
import RealmSwift

class CallCollectionAdapter: BaseCollectionAdapter {
    
    
    //Constant added is divided as follows 49 for the tab bar element and 44 for the navigation and 20 for the upper margins
    //total of 114 that makes the collection view perfect for all screen sizes
    override func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: self.viewController.view.frame.width/2, height: (self.viewController.view.frame.height-114)/3)
            
    }
    
    //created by Menna ElKharbotly
    
    func fetchItems() {
        
            API.get(APIRoutes.USER_SHOW, callback: { (success, response) in
                if(success){
                    
                    //map the jason object to the model and save them
                    let users = Mapper<User>().mapArray(response)
                    for user in users! {
                        self.tableItems.addObject(user)
                        
                    }
                     self.collectionView.reloadData()
                }
            })
        
            tableItems = ListModel()

    }
    
    
    
    //This number is just for testing
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.tableItems.count/2
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    //created by Menna ElKharbotly
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    //created by Menna ElKharbotly
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let name = (tableItems.objectAtIndex(indexPath.item) as! User).userFirstName + (tableItems.objectAtIndex(indexPath.item) as! User).userLastName
        let telephone = (tableItems.objectAtIndex(indexPath.item) as! User).userMobileNumber
        
        let alertController = UIAlertController(title: "Calling..", message:
            "Are you sure you want to call " + name, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.callNumber(telephone)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        
        self.viewController.presentViewController(alertController, animated: true, completion: nil)

        
    }
    
    
    
    
    //created by Menna ElKharbotly
    
    override func configure(cell: UICollectionViewCell, indexPath: NSIndexPath) {
        
        let _cell = cell as! CallCollectionViewCell
        
        
        let _firstName = (tableItems.objectAtIndex(indexPath.item) as! User).userFirstName
        let _LastName = (tableItems.objectAtIndex(indexPath.item) as! User).userLastName
        let _fullName = _firstName + _LastName
        let url = NSURL(string: "http://hr.staging.rails.robustastudio.com" + (tableItems.objectAtIndex(indexPath.item) as! User).userProfilePictureIconURL)
                
        _cell.image.sd_setImageWithURL(url)
        _cell.nameLabel.text = _fullName
        
        
        
    }
    
    
}
