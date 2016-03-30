//
//  CallViewController.swift
//  Robustivity
//
//  Created by Ali Soliman on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CallViewController: UIViewController {
    
    @IBOutlet weak var membersCollectionView: UICollectionView!
    var collectionViewAdapter:ModifiedBaseCollectionAdapter!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("CallViewController", owner: self, options: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Call";
        collectionViewAdapter = ModifiedBaseCollectionAdapter(viewController: self, collectionView: membersCollectionView, registerCellNib: "CallCollectionViewCell", withIdentifier: "CallCell")
    }

    
    class ModifiedBaseCollectionAdapter: BaseCollectionAdapter {
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
}
