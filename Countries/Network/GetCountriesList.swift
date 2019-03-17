//
//  GetCountriesList.swift
//  Countries
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit

struct Country: Codable {
    var name       = String()
    var nativeName = String()
    var borders    = [String]()
}

class GetCountriesList: BaseRequest<[Country]> {
    
    init(successCallback: @escaping RequestSuccessCallback<[Country]>, failureCallback: @escaping RequestFailureCallback) {
        
        let url = APIConstants.baseURL + APIConstants.Countries.allCountries
        
        super.init(method: .get, url: url)
        self.successCallback = successCallback
        self.failureCallback = failureCallback
    }
    
}
