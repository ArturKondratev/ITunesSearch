//
//  UIColor+Extensions.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

public extension UIColor {
    
    static let varna = UIColor.rgb(40.0, 35.0, 80.0)
    static let playerBackgroundStartColor = UIColor(red: 55/255.0,
                                                   green: 57/255.0,
                                                   blue: 63/255.0,
                                                   alpha: 1)
    static let playerBackgroundEndColor = UIColor(red: 27/255.0,
                                                  green: 27/255.0,
                                                  blue: 29/255.0,
                                                  alpha: 1)
}

public extension UIColor {
    
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor.rgba(r, g, b, 1.0)
    }
    
    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
     
    
}
