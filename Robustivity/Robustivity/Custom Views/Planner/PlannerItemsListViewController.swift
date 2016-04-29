//
//  PlannerItemsListViewController.swift
//  Robustivity
//
//  Created by Ahmed Elassuty on 4/29/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class PlannerItemsListViewController: BaseViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    @IBOutlet weak var tableView:UITableView!
    
    var adapter:PlannerItemsListAdapter!
    var itemType:TaskType!
    var itemSection:Int!

    var searchController:UISearchController!
    var refreshControl:UIRefreshControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        adapter = PlannerItemsListAdapter(viewController: self, tableView: tableView, registerCellWithNib: "PlannerTableViewCell", withIdentifier: "PlannerItemCell")
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        addSearchController()
        addRefreshControl()
        
        self.navigationController?.hidesBarsOnSwipe = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
    }
    
    // MARK: RefreshControl
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "startRefreshControl", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func startRefreshControl() {
        adapter.fetchFromServer()
    }
    
    func stopRefreshControl() {
        refreshControl.endRefreshing()
    }
    
    // MARK: Search Controller
    func addSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self

        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false

        self.definesPresentationContext = true

        self.navigationItem.titleView = searchController.searchBar
    }
    

    // MARK: Search Controller Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if searchController.searchBar.text == "" {
            let data = adapter.fetchFromDatabase()
            adapter.refreshTable(data, animationOptions: .TransitionCrossDissolve)
            return
        }
        
        let data = TaskModel.filterAll(itemType, startsWith: searchController.searchBar.text!)
        adapter.refreshTable(data, animationOptions: .TransitionCrossDissolve)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
