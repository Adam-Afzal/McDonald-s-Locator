//
//  StoreLocation.swift
//  mcdonald Locator
//
//  Created by Kyle on 22/02/2018.
//  Copyright © 2018 Kyle. All rights reserved.
//

import Foundation

class StoreLocation: Codable {
    
    var StoreName: String
    var Street: String
    var City: String
    var Postcode: String
    var Latitude: Float
    var Longitude: Float
}
