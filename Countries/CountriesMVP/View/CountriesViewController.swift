//
//  CountriesViewController.swift
//  Countries
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController { 

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CountriesPresenterProtocol!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        
        refreshControl.tintColor = UIColor.darkGray
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load countries
        presenter.loadData()
        
        // tableview settings
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // reload table view after pulling to refresh
        presenter.loadData()
        refreshControl.endRefreshing()
    }
}


