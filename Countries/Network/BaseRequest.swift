//
//  BaseRequest.swift
//  Countries
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import Foundation
import Alamofire

public typealias RequestSuccessCallback<T: Codable> = ((_ httpCode: Int?, _ parsedResponce: T)->())
public typealias RequestFailureCallback = ((_ httpCode: Int?, _ title: String, _ message: String)->())

class BaseRequest<T: Codable> {
    
    let method: HTTPMethod
    var url: String
    let params: [String: Any]?
    var dataRequest: DataRequest!
    var sessionManager: SessionManager!
    var encoding: ParameterEncoding!
    
    var successCallback: RequestSuccessCallback<T>?
    var failureCallback: RequestFailureCallback?
    
    // MARK: - Lifecycle
    
    init(method: HTTPMethod,
         encoding: ParameterEncoding = JSONEncoding.default,
         url: String,
         params: [String: Any]? = nil) {
        
        self.method              = method
        self.url                 = url
        self.encoding            = encoding
        self.params              = params
    }
    
    // MARK: - Execute
    func execute() {
        
        let configuration: URLSessionConfiguration = .default
        configuration.timeoutIntervalForRequest  = 100
        configuration.timeoutIntervalForResource = 100
        
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
        
        dataRequest = sessionManager.request(self.url, method: self.method, parameters: self.params, encoding: self.encoding).responseData(completionHandler: { (response) in
            
            switch response.result {
            case .success(let data):
                self.onSuccess(data, code: response.response?.statusCode)
                
            case .failure(let error):
                self.onError(error, code: response.response?.statusCode)
            }
        })
        
    }
    
    private func onSuccess(_ data: Data, code: Int?) {
        
        do {
            let apiResponse = try self.map(type: T.self, from: data)
            self.successCallback?(code, apiResponse)
            
        } catch {
            
            self.failureCallback?(code, "", error.localizedDescription)
        }
        
    }
    
    private func map<T:Codable>(type: T.Type, from data: Data) throws -> T {
        return try JSONDecoder().decode(type, from: data)
    }
    
    private func onError(_ error: Error, code: Int?) {
        self.failureCallback?(code, "", error.localizedDescription)
    }
}
