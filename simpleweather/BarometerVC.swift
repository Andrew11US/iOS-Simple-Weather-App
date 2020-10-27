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
    @IBOutlet weak var pressureMmHgLbl: UILabel!
    @IBOutlet weak var pressureKPaLbl: UILabel!
    @IBOutlet weak var pressureInHgLbl: UILabel!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var menuBtn: CustomButton!
    @IBOutlet weak var circleBar: UICircularProgressRingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPressure()
        errorLbl.text = handleError(type: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            self.errorLbl.isHidden = true
            print("P:", pressureKPa)
            self.pressureMmHgLbl.text = "\(pressureMmHg) mm Hg"
            self.pressureInHgLbl.text = "\(pressureInHg) in Hg"
            self.pressureKPaLbl.text = "\(pressureKPa) KPa"
            self.circleBar.setProgress(value: CGFloat(pressureMmHg), animationDuration: 1.0, completion: {
                print("Animated!")
            })
        }
    }
    
    @IBAction func dismiss(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func handleError(type: Int)-> String {
        errorLbl.isHidden = false
        
        if type == 0 {
            return "Calculating..."
        } else if type == 1 {
            return "Unable to load barometer data"
        } else {
            return "--"
        }
    }

}
