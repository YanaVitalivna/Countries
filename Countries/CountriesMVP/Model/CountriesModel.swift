//
//  CountriesModel.swift
//  Countries
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import Foundation

class CountriesModel: CountriesModelProtocol {
    
    weak var presenter: CountriesModelUpdatedProtocol?
    var countries = [Country]()
    var selectedCountry: Country?
    
    init(presenter: CountriesModelUpdatedProtocol) {
        self.presenter = presenter
    }
    
    func loadData() {
        guard selectedCountry == nil else {
            return getCountryBorders()
        }
        
        GetCountriesList.init(successCallback: { [weak self] (code, countries) in
            self?.countries = countries
            self?.presenter?.countriesLoaded(with: countries)
            
        }) { [weak self] (code, title, message) in
            self?.presenter?.error(info: message)
            
        }.execute()
    }
    
    func getCountryBorders() {
        guard selectedCountry != nil else {
            return
        }
       
        GetCountryBordersRequest.init(borders: selectedCountry!.borders, successCallback: { [weak self] (code, info) in
            self?.countries = info
            self?.presenter?.countriesLoaded(with: info)
            
        }) { [weak self] (code, title, message) in
            self?.presenter?.error(info: message)
            
        }.execute()
    }
    
    func getNumberOfCountries() -> Int {
        countries.count
    }
    
    func getCountry(for index: Int) -> Country {
        countries[index]
    }
    
    func getSelectedCountry() -> Country? {
        selectedCountry
    }
}
