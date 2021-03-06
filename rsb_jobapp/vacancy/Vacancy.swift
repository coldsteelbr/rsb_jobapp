//
//  Vacancy.swift
//  rsb_jobapp
//
//  Created by Roman Brazhnikov on 13.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//
import Foundation
// for random vacancies
let titles = ["iOS Developer",
              "Ios Junior Developer",
              "Android Senior Developer",
              "QA Lead",
              "Sales manager"]

let descriptions = ["More than 3 years of experience",
                    "Finished projects on AppStore or Google Play",
                    "Big salary, cookies, console"]

let employers = ["Horns and Hooves, Inc",
                 "V&R production, Ltd",
                 "OOO AAA"]

let urls = ["https://example.com"]

/// Represents a vacancy entity
class Vacancy{
    let url: String
    let title: String
    let description: String
    var identificator: String?
    let employer: String
    
    init(_ url: String, _ title: String, _ description: String, _ employer: String){
        self.url = url
        self.title = title
        self.description = description
        identificator = UUID.init().uuidString
        self.employer = employer
    }
    
    convenience init(Random random: Bool){
        
        if random {
            
            var randomIndex: Int
            
            // URL
            randomIndex = Int(arc4random_uniform(UInt32(urls.count)))
            let url = urls[randomIndex]
            
            
            // title
            randomIndex = Int(arc4random_uniform(UInt32(titles.count)))
            let title = titles[randomIndex]
            
            // description
            randomIndex = Int(arc4random_uniform(UInt32(descriptions.count)))
            let description = descriptions[randomIndex]
            
            // employer
            randomIndex = Int(arc4random_uniform(UInt32(employers.count)))
            let employer = employers[randomIndex]
            
            self.init(url, title, description, employer)
        } else {
            self.init("", "", "", "")
        }
    }
}
