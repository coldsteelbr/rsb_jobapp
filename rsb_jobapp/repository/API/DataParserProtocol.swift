//
//  DataParser.swift
//  rsb_jobapp
//
//  Created by Roman Brazhnikov on 16.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

protocol DataParserProtocol {
    func fetchVacancyListFrom(JSON json: Data) -> HhResult
}
