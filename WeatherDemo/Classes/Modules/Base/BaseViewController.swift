//
//  BaseViewController.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import UIKit

protocol BaseViewProtocol: AnyObject {
    func showError(message: String)
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension BaseViewController: BaseViewProtocol {
    
    func showError(message: String) {
        let alert = UIAlertController(title: L10n.error, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: L10n.ok, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
