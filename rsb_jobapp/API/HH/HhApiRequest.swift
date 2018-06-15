//
//  HhApiRequest.swift
//  rsb_jobapp
//
//  Created by Roman Brazhnikov on 15.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

enum HhResult{
    case okay
    case error
}

struct HttpHeader {
    var name: String
    var value: String
}

struct UrlKeyValue {
    var key: String
    var value: String
    
    func getAsUrlPair() -> String {
        return "\(key)=\(value)"
    }
}

/// Represents Head Hunter's API request
class HhApiRequest: RequestProtocol {
    
    let apiName = "hh.ru"
    let baseUrl = "https://api.hh.ru"
    let userAgent = HttpHeader(name: "User-Agent", value: "JobApp/1.0 (mail@example.com)")
    var requestUrl:String?
    lazy var requestParameters = [UrlKeyValue]()
    
    //
    //  RequestProtocol methods
    //
    func getRequestPattern() -> String? {
        guard let requestUrl = requestUrl else {
            return nil
        }
        var request = baseUrl
        request.append(requestUrl)
        request.append("?")
        
        for urlParam in requestParameters {
            request.append(urlParam.getAsUrlPair())
            request.append("&")
        }
        
        
        return request
    }
    
    func getApiName() -> String? {
        return apiName
    }
}
