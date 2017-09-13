//
//  CurrentWeather.swift
//  simpleweather
//
//  Created by Andrew Foster on 10/25/16.
//  Copyright © 2016 Andrii Halabuda. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: String!
    var _pressure: String!
    var _humidity: String!
    var _wind: String!
    var _cloudiness: String!
    var _maxTemp: String!
    var _uvIndex: String!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = "Connection :("
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = "No"
        }
        return _weatherType
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = "--"
        }
        return _currentTemp
    }
    
    var pressure: String {
        if _pressure == nil {
            _pressure = "--"
        }
        return _pressure
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = "--"
        }
        return _humidity
    }
    
    var wind: String {
        if _wind == nil {
            _wind = "--"
        }
        return _wind
    }
    
    var cloudiness: String {
        if _cloudiness == nil {
            _cloudiness = "--"
        }
        return _cloudiness
    }
    
    var maxTemp: String {
        if _maxTemp == nil {
            _maxTemp = "--"
        }
        return _maxTemp
    }
    
    var uvIndex: String {
        if _uvIndex == nil {
            _uvIndex = "--"
        }
        return _uvIndex
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        // Download current weather data
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                print(dict)
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
              
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                    
                    if let description = weather[0]["description"] as? String {
//                        self._weatherType = description.capitalized
                        print(description.capitalized)
                    }
                }
                
                if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                    
                    if let speed = wind["speed"] as? Double {
                        let speedRounded = Double(round(speed))
                        self._wind = String(Int(speedRounded))
                        print("Wind:" , self._wind)
                    }
                }
                
                if let cloudiness = dict["clouds"] as? Dictionary<String, AnyObject> {
                    
                    if let all = cloudiness["all"] as? Int {
                        
                        self._cloudiness = String(all)
                        print("Clouds:" , self._cloudiness)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemperature = main["temp"] as? Double {
                        
                        let kelvinToCelsiusRaw = (currentTemperature - 273.15)
                        let kelvinToCelsius = Double(round(10 * kelvinToCelsiusRaw/10))
                        self._currentTemp = String(Int(kelvinToCelsius))
                        print("Temp:", self._currentTemp)
                    }
                    
                    if let pressure = main["pressure"] as? Double {
                        
                        let pressureRound = Double(round(pressure))
                        self._pressure = String(Int(pressureRound))
                        print("Pressure:", self._pressure)
                    }
                    
                    if let humidity = main["humidity"] as? Int {
                        
                        self._humidity = String(humidity)
                        print("Humidity:", self._humidity)
                    }
                    
                    if let maxTemp = main["temp_max"] as? Double {
                        
                        let kelvinToCelsiusRaw = (maxTemp - 273.15)
                        let kelvinToCelsius = Double(round(10 * kelvinToCelsiusRaw/10))
                        self._maxTemp = String(Int(kelvinToCelsius))
                        print("maxTemp:", self._maxTemp)
                    }
                    
                }
            }
            completed()
        }
        
        Alamofire.request(UV_INDEX_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let uv = dict["value"] as? Double {
                    let uvRounded = Double(round(uv))
                    self._uvIndex = String(Int(uvRounded))
                    print("UV:" , self._uvIndex)
                }
            }
        }
    }
    
}
