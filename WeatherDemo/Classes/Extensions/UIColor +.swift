//
//  UIColor +.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import UIKit

extension UIColor {
    static let separator = UIColor(hex: 0xE3E3E3)
    static let imagePlaceholder = UIColor.black.withAlphaComponent(0.1)
}

fileprivate extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
}
