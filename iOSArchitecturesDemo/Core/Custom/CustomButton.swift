//
//  CustomButton.swift
//  iOSArchitecturesDemo
//
//  Created by Артур Кондратьев on 18.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setShadow()
        setTitleColor(.white, for: .normal)
        
        backgroundColor      = UIColor.black
        titleLabel?.font     = UIFont(name: "AvenirNext-DemiBold", size: 18)
        layer.cornerRadius   = 25
        layer.borderWidth    = 5.0
        layer.borderColor    = UIColor.playerBackgroundEndColor.cgColor
    }
    
    private func setShadow() {
        layer.shadowColor   = UIColor.lightGray.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 3.0)
        layer.shadowRadius  = 6
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    func shake() {
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 2
        shake.autoreverses  = true
        
        let fromPoint       = CGPoint(x: center.x - 3, y: center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)
        
        let toPoint         = CGPoint(x: center.x + 3, y: center.y)
        let toValue         = NSValue(cgPoint: toPoint)
        
        shake.fromValue     = fromValue
        shake.toValue       = toValue
        
        layer.add(shake, forKey: "position")
    }
}

