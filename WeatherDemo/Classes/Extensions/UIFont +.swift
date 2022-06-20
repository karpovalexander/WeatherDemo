//
//  UIFont +.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation
import UIKit

extension UIFont {
    
    static func medium(size: CGFloat) -> UIFont {
        FontFamily.Montserrat.medium.font(size: size)
    }
    
    static func regular(size: CGFloat) -> UIFont {
        FontFamily.Montserrat.regular.font(size: size)
    }
}
