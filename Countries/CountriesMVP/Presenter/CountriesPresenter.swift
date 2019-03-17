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
        self.view?.showActivityIndicator()
        self.model.loadData()
    }
    
    func getCountryBorders() {
        self.model.getCountryBorders()
    }
    
    func getNumberOfCountries() -> Int {
        return self.model.getNumberOfCountries()
    }
    
    func getCountry(for index: Int) -> Country {
        return self.model.getCountry(for: index)
    }
    
    func getSelectedCountry() -> Country? {
        return self.model.getSelectedCountry()
    }
    
}

//MARK: - CountriesModelUpdatedProtocol methods
extension CountriesPresenter: CountriesModelUpdatedProtocol {
    func countriesLoaded(with info: [Country]) {
        self.view?.hideActivityIndicator()
        self.view?.countriesLoaded(with: info)
    }
    
    func error(info: String) {
        self.view?.hideActivityIndicator()
        self.view?.error(info: info)
    }
}
