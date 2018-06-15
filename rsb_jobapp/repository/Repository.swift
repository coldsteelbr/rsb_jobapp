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
    
    private func performHttpForRequest(_ request: RequestProtocol){
        let url = URL.init(string: request.getRequestString()!)
        
        let urlRequest = URLRequest(url: url!)
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } else if let requestError = error {
                print("Error getting vacancies: \(requestError)")
            } else {
                print("Unexpected error")
            }
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
        performHttpForRequest(request)
        
        
        //
        // Placeholder
        //
        sleep(5)
        
        let vacancy_one = Vacancy("", "iOS", "dev", "emp1")
        let vacancy_two = Vacancy("", "iOS", "dev", "emp2")
        let vacancy_three = Vacancy("", "Android", "dev", "emp2")
        
        completion([vacancy_one, vacancy_two, vacancy_three])
    }
}
