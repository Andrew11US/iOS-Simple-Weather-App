//
//  InterfaceController.swift
//  WeatherGPS Extension
//
//  Created by Agent X on 12/1/17.
//  Copyright © 2017 Andrii Halabuda. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var weatherConditionImage: WKInterfaceImage!
    @IBOutlet var conditionLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
