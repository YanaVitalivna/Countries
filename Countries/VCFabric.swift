//
//  VCFabric.swift
//  Countries
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit

class ControllersFabric {
    
    static func performAssemnling<T>(type: AnyObject, with data: Any?) -> T {
        switch type {
            
        case is CountriesViewController.Type:
            return self.assembleCountries(data) as! T
            
        default:
            fatalError("Unhandeled entity type, add case for assembling")
        }
    }
    
    static func check<InjectionType>(data: Any?) -> InjectionType {
        guard let injectionData = data as? InjectionType else { fatalError("Injection data type ERROR") }
        return injectionData
    }
    
}

// MARK: - Assambling methods
extension ControllersFabric {
    
    static func assembleCountries(_ data: Any?) -> CountriesViewController {
        let vc = UIStoryboard.storyboards.countriesFlow.initiate().initiateVC(CountriesViewController.self)

        let presenter = CountriesPresenter(view: vc)
        let model = CountriesModel(presenter: presenter)
        
        if data != nil {
            let country: Country = self.check(data: data)
            model.selectedCountry = country
        }
        presenter.model = model
        vc.presenter = presenter
        
        return vc
    }
}
