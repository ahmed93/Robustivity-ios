//
//  ListProjectsAdapter.swift
//  Robustivity
//
//  Created by Mahmoud Eldesouky on 4/2/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//
//
//  UserAdapter.swift
//  Robustivity
//
//  Created by Mahmoud Eldesouky on 3/31/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
// UserAdapter used to display the User TableViews, using the UserTableViewCell.
// Remove the tableView Separator from your controller using: self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None

class ListProjectsAdapter: BaseTableAdapter {
    var ChooseProjectController:ChooseProjectViewController!
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        ChooseProjectController = viewController as? ChooseProjectViewController

    }
    
    
    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
        API.get(APIRoutes.PROJECTS_MYPROJECTS, callback: { (success, response) in
            if(success){
                let projects = Mapper<Project>().mapArray(response)
                for project in projects! {
                    self.tableItems.addObject(project)
                    project.save()
                }
                self.tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, 1)), withRowAnimation: .Bottom)
                
            }
        })
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedProject = tableItems.objectAtIndex(indexPath.row) as! Project
        if self.ChooseProjectController.respondsToSelector(Selector("getTodo"))
        {
            if self.ChooseProjectController.getTodo()
            {
                let controller = CreateTaskViewController()
                viewController.navigationController?.pushViewController(controller, animated: true)
                controller.project_id = selectedProject.id
                controller.isTaskObject = false
            }
            else{
                let controller = ChooseAssigneeViewController(nibName: "ChooseAssigneeViewController", bundle: nil)
                viewController.navigationController?.pushViewController(controller, animated: true)
                controller.project_id = selectedProject.id
            }
        }

    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let projectCell = cell as? CustomProjectsListTableViewCell
        let project = tableItems.objectAtIndex(indexPath.row) as! Project
        projectCell?.projectNameLabel.text = project.name
        projectCell?.memberLabel.text = project.name
        projectCell?.marginUIView.backgroundColor = Theme.tableBackgroundColor()

    }

    

    
}
