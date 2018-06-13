//
//  VacanciesStore.swift
//  rsb_jobapp
//
//  Created by Roman Brazhnikov on 13.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class VacanciesStore{
    // Data
    var items: [Vacancy] = []
    
    //
    // Singleton
    //
    static var instance: VacanciesStore?
    static func getInstance() -> VacanciesStore{
        if instance == nil {
            instance = VacanciesStore()
            instance?.populateRandomly(forNumber: 25)
        }
        
        return instance!
    }
    private init(){}
    
    //
    // Dev time logic
    //
    
    /// populates with randomly generated data
    func populateRandomly(forNumber count: Int){
        if count > 0 {
            for _ in 0..<count {
                addVacancy(Vacancy(Random: true))
            }
        }
    }
    
    //
    // Logic
    //
    func addVacancy(_ vacancy: Vacancy){
        items.append(vacancy)
    }
}
