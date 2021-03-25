//
//  CountriesViewController + Extension.swift
//  Countries
//
//  Created by Yana on 25.03.2021.
//  Copyright © 2021 Yana. All rights reserved.
//

import UIKit

// MARK: - CountriesViewProtocol methods
extension CountriesViewController: CountriesViewProtocol {
    func countriesLoaded(with info: [Country]) {
        tableView.reloadData()
    }
    
    func error(info: String) {
        let alertVC = UIAlertController.init(title: info, message: "", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate methods
extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // get selected country
        let selectedCountry = presenter.getCountry(for: indexPath.row)
        
        // if there are no borders show alert
        guard selectedCountry.borders.isEmpty == false else {
            error(info: "There are no borders.")
            return
        }
        
        // open screen with borders
        guard let navVC = navigationController else {
            return
        }
        
        Router.present(CountriesViewController.self, with: selectedCountry, animated: true, using: .push(in: navVC))
    }
}

// MARK: - UITableViewDataSource methods
extension CountriesViewController: UITableViewDataSource {
    
    // set title for header in table view section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.getSelectedCountry()?.name
    }
    
    // set number of countries
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getNumberOfCountries()
    }
    
    // fill cell with country data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesCell", for: indexPath)
        let counryInfo = presenter.getCountry(for: indexPath.row)
        cell.textLabel?.text = counryInfo.nativeName
        
        return cell
    }
}
