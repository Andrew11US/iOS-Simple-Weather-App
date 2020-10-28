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
        errorLbl.text = handleError(type: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            self.errorLbl.isHidden = true
            self.pressureMmHgLbl.text = "\(pressureMmHg) mm Hg"
            self.pressureInHgLbl.text = "\(pressureInHg) in Hg"
            self.pressureKPaLbl.text = "\(pressureKPa) KPa"
            self.circleBar.minValue = 650
            self.circleBar.maxValue = 850
            self.circleBar.value = 651
            self.circleBar.startProgress(to: CGFloat(pressureMmHg), duration: 0)
        }
    }
    
    @IBAction func dismiss(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func handleError(type: Int) -> String {
        errorLbl.isHidden = false
        
        if type == 0 {
            return "Calculating..."
        } else if type == 1 {
            return "Unable to load pressure data"
        } else {
            return "--"
        }
    }

}
