//
//  CallViewController.swift
//  Robustivity
//
//  Created by Ali Soliman on 3/30/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CallViewController: BaseViewController {
    
    @IBOutlet weak var membersCollectionView: UICollectionView!
    var collectionViewAdapter:CallCollectionAdapter!
    
    
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
        collectionViewAdapter = CallCollectionAdapter(viewController: self, collectionView: membersCollectionView, registerCellNib: "CallCollectionViewCell", withIdentifier: "CallCell")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: NSSelectorFromString("dissmissView"))
    }
    
    
    func dissmissView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
