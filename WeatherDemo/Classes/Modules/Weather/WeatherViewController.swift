//
//  WeatherViewController.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import UIKit
import HPParallaxHeader
import MapKit
import SnapKit
import TableKit

protocol WeatherViewProtocol: BaseViewProtocol {
    func reload()
    func focusMap(at coordinate: CLLocationCoordinate2D)
}

class WeatherViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let mapView = MKMapView()
    
    private var presenter: WeatherPresenterProtocol?
    private lazy var tableDirector = TableDirector(tableView: tableView)
    private let section = TableSection()
    
    static func controller(city: City) -> WeatherViewController {
        let vc = StoryboardScene.Weather.initialScene.instantiate()
        let presenter = WeatherPresenter(city: city, view: vc)
        vc.presenter = presenter
        return vc
    }
    
    // MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        presenter?.loadData()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        section.headerHeight = .leastNormalMagnitude
        tableDirector += section
        navigationItem.title = presenter?.title
//
        let contentView = UIView()
        contentView.backgroundColor = .yellow
        contentView.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        tableView.parallaxHeader.view = contentView
        tableView.parallaxHeader.height = UIScreen.main.bounds.height / 3
        tableView.parallaxHeader.mode = .topFill
    }

    private func configureTableDirector() {
        guard let viewModels = presenter?.viewModels else {
            return
        }
        
        let rows = viewModels.map({
            TableRow<WeatherInfoTableViewCell>(item: $0)
        })
        section += rows
        tableDirector.reload()
    }
}

extension WeatherViewController: WeatherViewProtocol {
    
    func reload() {
        configureTableDirector()
    }
    
    func focusMap(at coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        mapView.setRegion(region, animated: true)
    }
}
