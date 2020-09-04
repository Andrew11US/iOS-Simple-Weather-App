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
var pressureData = 0
var pressureTorr = 0

func getPressure() {
    
    if CMAltimeter.isRelativeAltitudeAvailable() {
        altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { data, error in
            
            if error != nil {
                print("Error occured while loading data!")
                
            } else {
//                print("Pressure:", String(describing: data?.pressure))
                if let pressure = data?.pressure {
                    pressureData = Int(truncating: pressure)
                    pressureTorr = Int(7.5 * Double(pressureData))
                }
            }
        })
        
    } else {
        print("Altimeter is not available for this device")
    }
}

