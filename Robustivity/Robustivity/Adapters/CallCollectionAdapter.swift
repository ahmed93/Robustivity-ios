//
//  CallCollectionAdapter.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 4/2/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

class CallCollectionAdapter: BaseCollectionAdapter {
    //Constant added is divided as follows 49 for the tab bar element and 44 for the navigation and 20 for the upper margins
    //total of 114 that makes the collection view perfect for all screen sizes
    override func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: self.viewController.view.frame.width/2, height: (self.viewController.view.frame.height-114)/3)
            
    }
    //This number is just for testing
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
}
