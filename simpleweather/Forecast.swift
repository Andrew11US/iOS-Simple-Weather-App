//
//  Forecast.swift
//  simpleweather
//
//  Created by Andrew Foster on 10/26/16.
//  Copyright © 2016 Andrii Halabuda. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double {
                
                let kelvinToCelsiusRaw = (min - 273.15)
                
                let kelvinToCelsius = Double(round(10 * kelvinToCelsiusRaw/10))
                
                self._lowTemp = "\(kelvinToCelsius)"
            }
            
            if let max = temp["max"] as? Double {
                
                let kelvinToCelsiusRaw = (max - 273.15)
                
                let kelvinToCelsius = Double(round(10 * kelvinToCelsiusRaw/10))
                
                self._highTemp = "\(kelvinToCelsius)"
                
            }
        
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            // convert from UNIX Date
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
