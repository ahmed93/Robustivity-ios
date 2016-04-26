//
//  AttendanceLogAdapter.swift
//  Robustivity
//
//  Created by Jihan Adel on 4/26/16.
//  Copyright © 2016 BumbleBee. All rights reserved.

//  Edited by: Jihan Adel & Majd el shebokshy

import UIKit
import ObjectMapper
import RealmSwift

class AttendanceLogAdapter: BaseTableAdapter {
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
    }
    
    // MARK: Base Adapter Delegate methods
    func fetchItems() {
        if tableItems.count == 0 {
            tableItems = ListModel()

            API.get(APIRoutes.ATTENDANCELOG, callback: { (success, response) in
                if(success){
                    
                    //map the jason object to the model and save them
                    let workingDays = Mapper<WorkingDay>().mapArray(response)
                    let realm = try! Realm()
                    for day in workingDays! {
                        self.tableItems.addObject(day)
                        if (realm.objects(WorkingDay).filter("id == \(day.id)").count == 0) {
                            try! realm.write {
                                realm.add(day)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            })
        }

    }

    
    // MARK: Table view delegate and datasource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let day = tableItems.objectAtIndex(indexPath.row) as! WorkingDay
        if day.lateReason!.isEmpty {
            return 80.0
        }
        else {
            return 115.0
        }
    }
    
    // MARK: Parent Overridden Functions

    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let workingDayCell = cell as! AttendanceLogTableViewCell
        
        let day = tableItems.objectAtIndex(indexPath.row) as! WorkingDay
        workingDayCell.dateLabel.text     = day.date
        workingDayCell.checkinLabel.text  = day.checkIn
        workingDayCell.checkoutLabel.text = day.checkOut
        if day.lateReason!.isEmpty {
            workingDayCell.reason.text = ""

        } else {
            workingDayCell.reason.text = "Reason: " + day.lateReason!
            
        }
        workingDayCell.corePercentage.progress = (Float(day.cch!) / 100.0)
    }

    
}
