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
    @IBOutlet weak var pressureCentralLbl: UILabel!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var menuBtn: CustomButton!
    @IBOutlet weak var circleBar: UICircularProgressRingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        getPressure()
        errorLbl.text = handleError(type: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            self.errorLbl.isHidden = true
            print("P:", pressureData)
            self.pressureCentralLbl.text = String(pressureTorr)
            self.circleBar.setProgress(value: CGFloat(pressureTorr), animationDuration: 1.0, completion: {
                print("Animated!")
            })
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
