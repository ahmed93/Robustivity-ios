//
//  CreateTaskViewController.swift
//  Robustivity
//
//  Created by Mohamed Bahgat Elrakaiby on 3/27/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class CreateTaskViewController: BaseViewController, UITextViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var adapter:CreateTaskAdapter!
    
    var textViewDelegate:CreateTaskTextViewDelegate!
    var textFieldDelegate:CreateTaskTextFieldDelegate!
    
    override func viewDidLoad() {
        
        autoreleasepool{
        
        super.viewDidLoad();
        self.textViewDelegate = CreateTaskTextViewDelegate();
        self.textFieldDelegate = CreateTaskTextFieldDelegate();
        self.title = "Task info";
        self.navigationItem.title = "Task info";
        
        //Done button on right
        
        let doneButton = UIBarButtonItem();
        doneButton.title = "Done";
        self.navigationItem.rightBarButtonItem = doneButton;
        
        adapter = CreateTaskAdapter(viewController: self, tableView: tableView!, registerMultipleNibsAndIdenfifers: ["TextViewTaskViewCell":"textView", "LabelTextTaskViewCell":"label"]);
        }
        
    }

}
