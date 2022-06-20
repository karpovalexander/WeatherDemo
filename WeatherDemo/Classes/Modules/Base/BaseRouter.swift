//
//  BaseRouter.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import UIKit

class BaseRouter {
    
    weak var sourceViewController: UIViewController?
    
    init(sourceViewController: UIViewController) {
        self.sourceViewController = sourceViewController
    }
}
