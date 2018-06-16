//
//  HhApiRequest.swift
//  rsb_jobapp
//
//  Created by Roman Brazhnikov on 15.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

enum HhResult{
    case success([Vacancy])
    case error(Error)
}

enum Method: String {
    case vacancies = "/vacancies?"
}

/// Represents Head Hunter's API request
class HhApiRequest: RequestProtocol {
    let apiName = "hh.ru"
    let baseUrl = "https://api.hh.ru"
    let userAgent = ("User-Agent", "JobApp/1.0 (mail@example.com)")
    let requestMethod:Method
    let requestParameters: [String:String]?
    
    //
    //  Logic
    //
    
    init(RequestMethod method:Method, Params params: [String:String]){
        requestMethod = method
        requestParameters = params
    }
    
    //
    //  RequestProtocol methods
    //
    func getRequestString() -> String? {
        // building url address for HH API
        var components = URLComponents(string: baseUrl + requestMethod.rawValue)
        var queryItems = [URLQueryItem]()
        
        if let requestParams = requestParameters {
            for (name, value) in requestParams {
                let item = URLQueryItem(name: name, value: value)
                queryItems.append(item)
            }
        }
        
        components?.queryItems = queryItems
        
        return components?.url?.absoluteString
    }
    
    func getApiName() -> String? {
        return apiName
    }
}
