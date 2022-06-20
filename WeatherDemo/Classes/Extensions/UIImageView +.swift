//
//  UIImageView +.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Kingfisher
import UIKit

extension UIImageView {
    
    func setImage(with url: URL?) {
        kf.setImage(with: url, options: [.transition(.fade(0.2))])
    }
}
