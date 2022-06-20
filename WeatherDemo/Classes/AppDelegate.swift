//
//  AppDelegate.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureRootViewController()
        
        return true
    }
    
    // MARK: - Private
    
    private func configureRootViewController() {
        let viewController = CitiesViewController.controller()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.shadowImage = UIImage()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
    }
}
