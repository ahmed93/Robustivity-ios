//
//  CreateTaskTextViewDelegate.swift
//  Robustivity
//
//  Created by Mohamed Bahgat Elrakaiby on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CreateTaskTextViewDelegate : BaseViewController, UITextViewDelegate{
    
    //try to save default values for text views
    
    var defaultTextViewsValues = Dictionary<UITextView,String>();
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        if(textView.text == defaultTextViewsValues[textView]){
            
            textView.text = "";
        }
        
        return true;
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        
        if(textView.text.isEmpty){
            
            textView.text = defaultTextViewsValues[textView];
        }
        
        return true;
    }
    
    
}
