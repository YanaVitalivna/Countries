//
//  CountriesPresenter + Extension.swift
//  Countries
//
//  Created by Yana on 25.03.2021.
//  Copyright © 2021 Yana. All rights reserved.
//

import Foundation

//MARK: - CountriesModelUpdatedProtocol methods
extension CountriesPresenter: CountriesModelUpdatedProtocol {
    func countriesLoaded(with info: [Country]) {
        view?.hideActivityIndicator()
        view?.countriesLoaded(with: info)
    }
    
    func error(info: String) {
        view?.hideActivityIndicator()
        view?.error(info: info)
    }
}
