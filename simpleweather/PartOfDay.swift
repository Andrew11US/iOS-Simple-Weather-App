//
//  PartOfDay.swift
//  simpleweather
//
//  Created by Agent X on 11/25/17.
//  Copyright © 2017 Andrii Halabuda. All rights reserved.
//

import Foundation
import UIKit

func partOfDay() -> String {
    let hour = NSCalendar.current.component(.hour, from: Date())
    switch hour {
    case 5..<20 : return "Day"
    default: return "Night"
    }
}

