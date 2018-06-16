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
    
    // HTTP
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func performHttpForRequest(_ request: RequestProtocol, completion: @escaping (HhResult) -> Void){
        let url = URL.init(string: request.getRequestString()!)
        
        let urlRequest = URLRequest(url: url!)
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            var result = HhResult.success([])
            if let jsonData = data {
                //do {
                    var vacancyList = [Vacancy]()
                    switch(request.getApiName()){
                    case "hh.ru":
                        let dataParser = HhDataParser()
                        //vacancyList =
                        result = dataParser.fetchVacancyListFrom(JSON: jsonData)
                        switch(result){
                        case let .success(vacancies):
                            vacancyList = vacancies
                        case let .error(error):
                            print("Error while fetching vacancies: \(error)")
                        }
                    case "in-memory":
                        let vacancy_one = Vacancy("", "iOS m", "dev", "emp1")
                        let vacancy_two = Vacancy("", "iOS m", "dev", "emp2")
                        let vacancy_three = Vacancy("", "Android m", "dev", "emp2")
                        vacancyList = [vacancy_one, vacancy_two, vacancy_three]
                        result = HhResult.success(vacancyList)
                    default:
                        vacancyList = [Vacancy]()
                        print("\(#function): Unknown API");
                        result = HhResult.error(NSError(domain: "Uknown", code: 1, userInfo: nil))
                    }
                    print(vacancyList)
//                } catch {
//                    print("Error creating JSON object: \(error)")
//                }
            } else if let requestError = error {
                print("Error getting vacancies: \(requestError)")
            } else {
                print("Unexpected error")
            }
            
            completion(result)
        }
        task.resume()
    }
    
    //
    // Logic
    //
    
    /// Returns vacancies by request string
    public func getVacanciesFor(Request request: RequestProtocol, completion: @escaping ([Vacancy]) -> Void)  {
        // Asynchronous call
        DispatchQueue.global(qos: .userInteractive).async {
            var responseArray: [Vacancy]
            
            switch request.getApiName() {
            case "hh.ru":
                self.getVacanciesFromApiByRequest(request) {
                    (data) in
                    completion(data)
                }
            case "in-memory":
                // getting responseArray
                responseArray = self.getVacanciesFromMemoryForRequest(request)
                completion(responseArray)
            default:
                break
            }
            
        }
    }

    /// Returns in-memory response
    private func getVacanciesFromMemoryForRequest(_ request: RequestProtocol) -> [Vacancy] {
        sleep(5)
        return VacanciesStore.getInstance().items.filter({
            if let _ = $0.title.lowercased().range(of: request.getRequestString()!.lowercased()) {
                return true
            }
            return false
        })
    }
    
    /// Returns real data from http
    private func getVacanciesFromApiByRequest(_ request: RequestProtocol, completion: @escaping ([Vacancy]) -> Void){
        // performing HTTP(S) connection
        print("\(#function): URL: \(request.getRequestString() ?? "null" )")
        // HTTP:
        performHttpForRequest(request){
            (result) -> Void in
            switch result {
            case let .success(vacancies):
                    completion(vacancies)
                    print("Found: \(vacancies.count) vacancies")
            case let .error(error):
                print("Error: \(error)")
            }
        }
        
    }
}
