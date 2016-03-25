//
//  BaseCollectionAdapter.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/22/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class BaseCollectionAdapter: BaseAdapter {
    
    var collectionView:UICollectionView!
    var cellIdentifier:String!
    var viewController:UIViewController!
    
    var selectedIndexPath:NSIndexPath?
    
    init(viewController:UIViewController, collectionView:UICollectionView, cellIdentifier:String) {
        super.init()
        self.cellIdentifier = cellIdentifier
        self.collectionView = collectionView
        self.viewController = viewController
        
        commonSetup()
    }
    
    init(viewController:UIViewController, collectionView:UICollectionView,registerCellWithClass cellClass:AnyClass, withIdentifier cellIdentifier:String) {
        super.init()
        self.collectionView = collectionView
        self.cellIdentifier = cellIdentifier
        collectionView.registerClass(cellClass, forCellWithReuseIdentifier: cellIdentifier)
        self.viewController = viewController
        
        commonSetup()
    }

    init(viewController:UIViewController, collectionView:UICollectionView,registerCellNib nibName:String, withIdentifier cellIdentifier:String) {
        super.init()
        self.collectionView = collectionView
        self.cellIdentifier = cellIdentifier
        collectionView.registerNib(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.viewController = viewController
        
        commonSetup()
    }
    
    func commonSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        tableItems = ListModel()
    }

}


extension BaseCollectionAdapter: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
    }
}

extension BaseCollectionAdapter: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableItems!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        configure(cell, indexPath: indexPath)
        return cell
    }
    
    // Empty implementation to be overriden
    func configure(cell:UICollectionViewCell, indexPath:NSIndexPath) {
    }
}