//
//  WeatherCell.swift
//  simpleweather
//
//  Created by Andrew Foster on 10/26/16.
//  Copyright © 2016 Andrii Halabuda. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast: Forecast) {
        
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
//        weatherType.text = forecast.weatherType
        weatherIcon.image = UIImage(named: "B\(forecast.weatherType)")
        dayLbl.text = forecast.date
        
//        weatherIcon.image = UIImage(named: "Tornado")
        if weatherIcon.image == nil {
            weatherIcon.image = UIImage(named: "NoCondition")
            print("No Image!")
        }
        
    }


}
