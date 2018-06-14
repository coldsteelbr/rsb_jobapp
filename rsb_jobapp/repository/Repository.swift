//
//  Repository.swift
//  rsb_jobapp
//
//  Created by Roman Brazhnikov on 13.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class Repository{
    
    //
    //  Singleton
    //
    private static var instance: Repository?
    
    static func getInstance() -> Repository{
        if instance == nil {
            instance = Repository()
        }
        
        return instance!
    }
    private init(){}
    
    //
    // Logic
    //
    
    /// Returns vacancies by request string
    public func getVacanciesFor(Request request: String, completion: @escaping ([Vacancy]) -> Void)  {
        // Asynchronous call
        DispatchQueue.global(qos: .userInteractive).async {
            sleep(5)
            let responseArray = VacanciesStore.getInstance().items.filter({
                if let _ = $0.title.lowercased().range(of: request.lowercased()) {
                    return true
                }
                return false
            })
            
            //return responseArray
            completion(responseArray)
        }
    }
}
