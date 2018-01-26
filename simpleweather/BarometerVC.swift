//
//  BarometerVC.swift
//  simpleweather
//
//  Created by Agent X on 1/14/18.
//  Copyright © 2018 Andrii Halabuda. All rights reserved.
//

import UIKit
import UICircularProgressRing

class BarometerVC: UIViewController {
    
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var cloudinessLbl: UILabel!
    @IBOutlet weak var uvIndexLbl: UILabel!
    @IBOutlet weak var pressureCentralLbl: UILabel!

    @IBOutlet weak var menuBtn: CustomButton!
    @IBOutlet weak var circleBar: UICircularProgressRingView!
    
    var currentWeather: CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentWeather = CurrentWeather()
        
//        updateMainUI()
        self.pressureCentralLbl.text = String(pressureTorr)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in

            print("P:", pressureData)
            self.circleBar.setProgress(value: CGFloat(pressureTorr), animationDuration: 1.0, completion: {
                print("Animated!")
            })
        }
        updateMainUI()
//        animate()
    }

    func animate() {
        circleBar.setProgress(value: 750, animationDuration: 1.0) {
            print("Done animating!")
        }
    }
    
    func updateMainUI() {
        
//        humidityLbl.text = currentWeather.humidity
//        windLbl.text = currentWeather.wind
//        cloudinessLbl.text = currentWeather.cloudiness
//        uvIndexLbl.text = currentWeather.uvIndex
//        pressureLbl.text = currentWeather.pressure
        
    }

}
