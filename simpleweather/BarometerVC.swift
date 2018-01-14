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

    @IBOutlet weak var menuBtn: CustomButton!
    @IBOutlet weak var circleBar: UICircularProgressRingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
//
//            self.animate()
//        }
        
        animate()
    }

    func animate() {
        circleBar.setProgress(value: 750, animationDuration: 1.0) {
            print("Done animating!")
        }
    }

}
