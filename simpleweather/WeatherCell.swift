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
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configure(forecast: Forecast) {
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        adaptImages(forecast: forecast)
        dayLbl.text = forecast.date
    }
    
    private func adaptImages(forecast: Forecast) {
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            weatherIcon.image = UIImage(named: "B\(forecast.weatherType)")
        case .dark:
            weatherIcon.image = UIImage(named: "\(forecast.weatherType)")
        @unknown default:
            weatherIcon.image = UIImage(named: "B\(forecast.weatherType)")
        }
        
        if weatherIcon.image == nil {
            weatherIcon.image = UIImage(named: "NoCondition")
        }
    }
    
    
}
