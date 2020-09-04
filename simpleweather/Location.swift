//
//  Location.swift
//  simpleweather
//
//  Created by Andrew Foster on 10/26/16.
//  Copyright © 2016 Andrii Halabuda. All rights reserved.
//

import CoreLocation

class Location {
    static let shared = Location()
    private init () {}
    
    var latitude: Double!
    var longitude: Double!
}
