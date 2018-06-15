//
//  RequestProtocol.swift
//  rsb_jobapp
//
//  Created by Roman Brazhnikov on 15.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    func getRequestPattern() -> String?
    func getApiName() -> String?
}
