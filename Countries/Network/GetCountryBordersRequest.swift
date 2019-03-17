//
//  GetCountryBordersRequest.swift
//  Countries
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import Foundation
import Alamofire

class GetCountryBordersRequest: BaseRequest<[Country]> {
    
    init(borders: [String], successCallback: @escaping RequestSuccessCallback<[Country]>, failureCallback: @escaping RequestFailureCallback){
       
        let params = [APIConstants.Countries.codes: borders.joined(separator: ";")]
        let url = APIConstants.baseURL + APIConstants.Countries.bourders
        
        super.init(method: .get, encoding: URLEncoding.default, url: url, params: params)
        self.successCallback = successCallback
        self.failureCallback = failureCallback
    }
}
