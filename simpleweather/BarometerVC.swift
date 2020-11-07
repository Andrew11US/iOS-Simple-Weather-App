//
//  BarometerVC.swift
//  simpleweather
//
//  Created by Agent X on 1/14/18.
//  Copyright © 2018 Andrii Halabuda. All rights reserved.
//

import UIKit

class BarometerVC: UIViewController {
    @IBOutlet weak var pressureMmHgLbl: UILabel!
    @IBOutlet weak var pressureKPaLbl: UILabel!
    @IBOutlet weak var pressureInHgLbl: UILabel!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var menuBtn: CustomButton!
    @IBOutlet weak var circleBar: UICircularProgressRing!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPressure()
        self.circleBar.minValue = 650
        self.circleBar.maxValue = 850
        self.circleBar.value = 651
        
//        pressureKPa = 101.4386
//        pressureInHg = Double(101.4386 / 3.386).round(places: 2)
//        pressureMmHg = Int(7.501 * pressureKPa)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            if pressureMmHg == 0 {
                self.errorLbl.text = "Altimeter is not available"
            }
            self.pressureMmHgLbl.text = "\(pressureMmHg) mm Hg"
            self.pressureInHgLbl.text = "\(pressureInHg) in Hg"
            self.pressureKPaLbl.text = "\(pressureKPa) KPa"
            self.circleBar.startProgress(to: CGFloat(pressureMmHg), duration: 1.5)
        }
    }
    
    @IBAction func dismiss(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
