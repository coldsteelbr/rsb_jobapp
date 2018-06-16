//
//  HhDataParser.swift
//  rsb_jobapp
//
//  Created by Roman Brazhnikov on 16.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class HhDataParser: DataParserProtocol {
    
    func fetchVacancyListFrom(JSON json: Data) -> HhResult {
        do{
            let jsonObject = try JSONSerialization.jsonObject(with: json, options: [])
            print(jsonObject)
            
            /*
             
             guard let dictionary = jsonObject as? [String: Any],
             let items = dictionary["items"] as? [[String:Any]]
             
             */
            guard let jsonDictionary  = jsonObject as? [AnyHashable:Any],
                let vacancies = jsonDictionary["items"] as? [[String:Any]] else {
                    return .error(NSError(domain: "Fail", code: 1, userInfo: nil))
            }
            
            var vacancyList = [Vacancy]()
            
            for item in vacancies {
                let title = item["name"] as? String
                let vacancy = Vacancy("", title!, "", "")
                vacancyList.append(vacancy)
            }
            
            //vacancyList = [Vacancy.init(Random: true), Vacancy.init(Random: true)]
            return .success(vacancyList)
        } catch {
            return .error(error)
        }
       
    }
    
    
}
