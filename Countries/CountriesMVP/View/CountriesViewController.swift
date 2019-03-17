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
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.darkGray
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load countries
        self.presenter.loadData()
        
        // tableview settings
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.addSubview(self.refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // reload table view after pulling to refresh
        self.presenter.loadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - CountriesViewProtocol methods
extension CountriesViewController: CountriesViewProtocol {
    func countriesLoaded(with info: [Country]) {
        self.tableView.reloadData()
    }
    
    func error(info: String) {
        let alertVC = UIAlertController.init(title: info, message: "", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate methods
extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // get selected country
        let selectedCountry = self.presenter.getCountry(for: indexPath.row)
        
        // if there are no borders show alert
        guard !selectedCountry.borders.isEmpty else {
            self.error(info: "There are no borders.")
            return
        }
        
        // open screen with borders
        guard let navVC = self.navigationController else { return }
        Router.present(CountriesViewController.self, with: selectedCountry, animated: true, using: .push(in: navVC))
    }
}

// MARK: - UITableViewDataSource methods
extension CountriesViewController: UITableViewDataSource {
    
    // set title for header in table view section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.presenter.getSelectedCountry()?.name
    }
    
    // set number of countries
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getNumberOfCountries()
    }
    
    // fill cell with country data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesCell", for: indexPath)
        let counryInfo = self.presenter.getCountry(for: indexPath.row)
        cell.textLabel?.text = counryInfo.nativeName
        return cell
    }
    
    
}
