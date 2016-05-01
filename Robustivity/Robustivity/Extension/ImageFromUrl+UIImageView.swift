//
//  ImageFromUrl+UIImageView.swift
//  Robustivity
//
//  Created by khaled elhossiny on 4/27/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
extension UIImageView{
    /*
    Made by Khaled Elhossiny
    this extension is for loading imageview with a url aysnc
    */
    func downloadImageFromUrl(urlString: String){
        if let url = NSURL(string: urlString) {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                if error == nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        let image = UIImage(data: data!)
                        self.image = image
                    }
                }
            }
            task.resume()
        }
    }
}