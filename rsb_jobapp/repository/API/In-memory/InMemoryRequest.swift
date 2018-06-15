//
//  InMemoryRequest.swift
//  rsb_jobapp
//
//  Created by Roman Brazhnikov on 15.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class InMemoryRequest: RequestProtocol {
    let apiName = "in-memory"
    let filter: String
    
    init(forFilter filter: String) {
        self.filter = filter
    }
    
    func getRequestString() -> String? {
        return filter
    }
    
    func getApiName() -> String? {
        return apiName
    }
    
}
