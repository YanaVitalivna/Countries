//
//  CountriesProtocol.swift
//  Countries
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import Foundation

protocol CountriesPresenterProtocol: class {
    func loadData()
    func getCountryBorders()
    func getNumberOfCountries() -> Int
    func getCountry(for index: Int) -> Country
    func getSelectedCountry() -> Country?
}

protocol CountriesModelProtocol: class {
    func loadData()
    func getCountryBorders()
    func getNumberOfCountries() -> Int
    func getCountry(for index: Int) -> Country
    func getSelectedCountry() -> Country?
}

protocol CountriesViewProtocol: BaseViewInterface {
    func countriesLoaded(with info: [Country])
    func error(info: String)
}

protocol CountriesModelUpdatedProtocol: class {
    func countriesLoaded(with info: [Country])
    func error(info: String)
}
