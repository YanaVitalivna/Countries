//
//  CountriesPresenter.swift
//  Countries
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import Foundation

class CountriesPresenter: CountriesPresenterProtocol {
   
    weak var view: CountriesViewProtocol?
    var model: CountriesModelProtocol!
    
    init(view: CountriesViewProtocol) {
        self.view = view
    }
    
    func loadData() {
        view?.showActivityIndicator()
        model.loadData()
    }
    
    func getCountryBorders() {
        model.getCountryBorders()
    }
    
    func getNumberOfCountries() -> Int {
        model.getNumberOfCountries()
    }
    
    func getCountry(for index: Int) -> Country {
        model.getCountry(for: index)
    }
    
    func getSelectedCountry() -> Country? {
        model.getSelectedCountry()
    }
    
}

