//
//  BackgroundImage.swift
//  simpleweather
//
//  Created by Andrew Foster on 10/27/16.
//  Copyright © 2016 Andrii Halabuda. All rights reserved.
//

import Foundation
import  UIKit

class BackgroundImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        playAnimation()
    }
    
    @objc func playAnimation() {
        
        self.image = UIImage(named: "bg.jpg")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for x in 1...8 {
            let img = UIImage(named: "bg\(x).jpg")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 50.0
        self.animationRepeatCount = 0
        self.startAnimating()
    }

    
}
