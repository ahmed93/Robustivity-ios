//
//  AttendanceLogViewController.swift
//  Robustivity
//
//  Created by Jihan Adel on 4/25/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//
//  Edited by: Jihan Adel & Majd el shebokshy

import UIKit

class AttendanceLogViewController: BaseViewController {
    
    @IBOutlet weak var logTable: UITableView!
    var adapter:AttendanceLogAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        self.title = "More";
        self.navigationItem.title = "Attendance Log";
        
        adapter = AttendanceLogAdapter(viewController: self, tableView: logTable, registerCellWithNib:"AttendanceLogTableViewCell", withIdentifier: "AttendaceLogCell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
