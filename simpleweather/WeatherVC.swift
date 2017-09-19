//
//  WeatherVC.swift
//  simpleweather
//
//  Created by Andrew Foster on 10/16/16.
//  Copyright © 2016 Andrii Halabuda. All rights reserved.
//
///---Future releases---///
//-> Barometer screen
//-> AdMob

import UIKit
import CoreLocation
import CoreMotion
import Alamofire
import Foundation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var currentWeatherTypeLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var background: BackgroundImage!
    @IBOutlet weak var updateWeather: UIButton!
    
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var cloudinessLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var uvIndexLbl: UILabel!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    let altimeter = CMAltimeter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        currentWeather = CurrentWeather()
        locationAutoStatus()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake {
            print("Shake")
            
            updateWeatherDetails()
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
    
    func locationAutoStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            currentLocation = locationManager.location
            
            if locationManager.location == nil {
            
                locationLbl.text = "Unable to Position :("
                currentWeatherImg.image = UIImage(named: "No")
                
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.warning)
                
                
                // LA
                Location.shared.latitude = 34.052235
                Location.shared.longitude = -118.243683
                
                // Tokyo
//                Location.shared.latitude = 35.652
//                Location.shared.longitude = 139.839
                
                // London
//                Location.shared.latitude = 51.508530
//                Location.shared.longitude = -0.076132
                
                // Sydney
//                Location.shared.latitude = -33.8688
//                Location.shared.longitude = 151.2093
                
                // New York
//                Location.shared.latitude = 40.71
//                Location.shared.longitude = -74.01
                
                currentWeather.downloadWeatherDetails {
                    self.downloadForecastData {
                        self.updateMainUI()
                    }
                }
                
            
                print("No GPS")
            } else {
            
                Location.shared.latitude = currentLocation.coordinate.latitude
                Location.shared.longitude = currentLocation.coordinate.longitude
            
                currentWeather.downloadWeatherDetails {
                    self.downloadForecastData {
                    self.updateMainUI()
                    }
                }
            }
            
        } else if CLLocationManager.authorizationStatus() == .notDetermined {
            
            locationManager.requestWhenInUseAuthorization()
            
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                
                self.locationAutoStatus()
            }
            
        } else {
            
            locationLbl.text = "Unable to Position :("
            currentWeatherImg.image = UIImage(named: "No")
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
        
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        // Downloading forecast weather data for TableView
        
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
//                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
//            let forecast = forecasts[indexPath.row]
//            cell.configureCell(forecast: forecast)
            
            if forecasts.count != 0 {
                let forecast = forecasts[indexPath.row]
                cell.configureCell(forecast: forecast)
            } else {
//                currentWeatherImg.image = UIImage(named: "No")
//                currentWeatherTypeLbl.text = "No"
//                locationLbl.text = "Connection :("
            }
            return cell
        } else {
            return WeatherCell()
        }
    }

    func updateMainUI() {
        
        dateLbl.text = currentWeather.date
        currentTempLbl.text = currentWeather.currentTemp
        currentWeatherTypeLbl.text = currentWeather.weatherType
        locationLbl.text = currentWeather.cityName
        humidityLbl.text = currentWeather.humidity
        windLbl.text = currentWeather.wind
        cloudinessLbl.text = currentWeather.cloudiness
        uvIndexLbl.text = currentWeather.uvIndex
        pressureLbl.text = currentWeather.pressure
        currentWeatherImg.image = UIImage(named: currentWeather.weatherType)
//        currentWeatherImg.image = UIImage(named: "Tornado")
        
        if currentWeatherImg.image == nil {
            currentWeatherImg.image = UIImage(named: "NoCondition")
            print("No Image!")
        }
        
        if forecasts.count == 0 {
            currentWeatherImg.image = UIImage(named: "No")
            currentWeatherTypeLbl.text = "No"
            locationLbl.text = "Connection :("
            currentTempLbl.text = "--"
            humidityLbl.text = "--"
            windLbl.text = "--"
            cloudinessLbl.text = "--"
            uvIndexLbl.text = "--"
            pressureLbl.text = "--"
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
    }
    
    func updateWeatherDetails() {
        
        if forecasts.count > 0 {
            forecasts.removeAll()
        }
        
        locationAutoStatus()
    }
}

