//
//  Constants.swift
//  simpleweather
//
//  Created by Andrew Foster on 10/25/16.
//  Copyright © 2016 Andrii Halabuda. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.shared.latitude!)&lon=\(Location.shared.longitude!)&appid=7ec0aa8b6805ce23f0dcaf95a188fd02"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.shared.latitude!)&lon=\(Location.shared.longitude!)&cnt=10&mode=json&appid=7ec0aa8b6805ce23f0dcaf95a188fd02"

let UV_INDEX_URL = "http://api.openweathermap.org/data/2.5/uvi?appid=7ec0aa8b6805ce23f0dcaf95a188fd02&lat=\(Location.shared.latitude!)&lon=\(Location.shared.longitude!)"
