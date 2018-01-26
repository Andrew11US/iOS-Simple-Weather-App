//
//  CustomImage.swift
//  simpleweather
//
//  Created by Agent X on 1/26/18.
//  Copyright © 2018 Andrii Halabuda. All rights reserved.
//

import UIKit

@IBDesignable
class CustomImage: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
        self.layer.masksToBounds = false
    }
    
    

}
