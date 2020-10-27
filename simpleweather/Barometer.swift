//
//  Barometer.swift
//  simpleweather
//
//  Created by Andrew Foster on 9/12/17.
//  Copyright © 2017 Andrii Halabuda. All rights reserved.
//

import UIKit
import Foundation
import CoreMotion

let altimeter = CMAltimeter()
var pressureKPa = 0.0
var pressureInHg = 0.0
var pressureMmHg = 0

func getPressure() {
    if CMAltimeter.isRelativeAltitudeAvailable() {
        altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { data, error in
            if error != nil {
                print("Error occured while loading data!")
            } else {
                if let pressure = data?.pressure {
                    pressureKPa = Double(truncating: pressure).round(places: 4)
                    pressureInHg = Double(Double(truncating: pressure) / 3.386).round(places: 2)
                    pressureMmHg = Int(7.501 * pressureKPa)
                }
            }
        })
    } else {
        print("Altimeter is not available for this device")
    }
}

