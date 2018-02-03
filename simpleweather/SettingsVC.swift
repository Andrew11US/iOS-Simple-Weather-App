//
//  SettingsVC.swift
//  simpleweather
//
//  Created by Agent X on 1/14/18.
//  Copyright © 2018 Andrii Halabuda. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var scaleSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeSwitchControl()
    }
    
    @IBAction func scaleSwitchChanged(_ sender: Any) {
        
        if scaleSwitch.isOn {
            celsiusSelected = true
            UserDefaults.standard.set(celsiusSelected, forKey: "celsiusSelected")
            
        } else {
            celsiusSelected = false
            UserDefaults.standard.set(celsiusSelected, forKey: "celsiusSelected")
        }
        
        print(celsiusSelected)
    }
    
    func changeSwitchControl() {
        
        if celsiusSelected {
            
            scaleSwitch.isOn = true
        } else {
            
            scaleSwitch.isOn = false
        }
        
        print(celsiusSelected)
    }

}
