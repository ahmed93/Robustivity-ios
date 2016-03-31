//
//  CreateTaskTextFieldDelegate.swift
//  Robustivity
//
//  Created by Mohamed Bahgat Elrakaiby on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CreateTaskTextFieldDelegate : BaseViewController, UITextFieldDelegate{
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text;
        
        if(text?.characters.count >= 10 && string.characters.count == 1){
            return false;
        }
        
        let letters = NSCharacterSet.letterCharacterSet();
        let number = string.rangeOfCharacterFromSet(letters)?.count;
        
        if(number >= 1){
            return false;
        }
        
        let numberOfGroups = (text?.componentsSeparatedByString(".").count)! - 1;
        
        if(!(text?.isEmpty)! && !(string.isEmpty) && ((text?.characters.count)! - numberOfGroups) % 2 == 0){
            
            if(numberOfGroups < 2){
                textField.text = text! + ".";
            }
        }
        
        return true;
    }
}
