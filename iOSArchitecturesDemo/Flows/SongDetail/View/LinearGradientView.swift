//
//  LinearGradientView.swift
//  iOSArchitecturesDemo
//
//  Created by Артур Кондратьев on 18.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class LinearGradientView: UIView {
    
    // MARK: - Properties
    let topColor: UIColor = UIColor.playerBackgroundStartColor
    let bottomColor: UIColor = UIColor.playerBackgroundEndColor
    let gradientLayer = CAGradientLayer()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - UI
    private func commonInit() {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.type = .radial

        layer.addSublayer(gradientLayer)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if gradientLayer.frame != bounds {
            gradientLayer.frame = bounds
        }
    }
}
