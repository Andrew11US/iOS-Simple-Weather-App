//
//  Double+Extension.swift
//  simpleweather
//
//  Created by Andrew on 10/27/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import Foundation

extension Double {
    func round(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
