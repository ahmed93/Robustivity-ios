//
//  CreateTaskViewController.swift
//  Robustivity
//
//  Created by Mohamed Bahgat Elrakaiby on 3/27/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CreateTaskViewController: BaseViewController, UITextViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var adapter:CreateTaskAdapter!
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
            
        self.title = "Task info";
        self.navigationItem.title = "Task info";
        
        //Done button on right
        
        let doneButton = UIBarButtonItem();
        doneButton.title = "Done"
        doneButton.target = self
        doneButton.action = NSSelectorFromString("doneButtonPress");
        self.navigationItem.rightBarButtonItem = doneButton;
        
        adapter = CreateTaskAdapter(viewController: self, tableView: tableView!, registerMultipleNibsAndIdenfifers: ["TextViewTaskViewCell":"textViewCell", "LabelTextTaskViewCell":"labelCell"]);
        
    }
    
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
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text;
        
        if(text?.characters.count >= 10 && string.characters.count == 1){
            return false;
        }
        
        let letters = NSCharacterSet.letterCharacterSet();
        let specialC = NSCharacterSet.alphanumericCharacterSet().invertedSet;
        let numberL = string.rangeOfCharacterFromSet(letters)?.count;
        let number = string.rangeOfCharacterFromSet(specialC)?.count;
        
        if(number >= 1 || numberL >= 1){
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
    
    func doneButtonPress(){
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }

}
