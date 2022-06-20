//
//  CitiesViewController.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import UIKit
import TableKit

protocol CitiesViewProtocol: BaseViewProtocol {
    func updateLoaderState(isLoading: Bool)
    func reload()
}

class CitiesViewController: BaseViewController {

    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var router: CitiesRouterProtocol = CitiesRouter(sourceViewController: self)
    private lazy var presenter: CitiesPresenterProtocol = CitiesPresenter(view: self, router: router)
    private lazy var tableDirector = TableDirector(tableView: tableView)
    
    private let section = TableSection()
    
    // MARK: - lifeCycle
    
    static func controller() -> CitiesViewController {
        StoryboardScene.Cities.initialScene.instantiate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        presenter.loadData()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        navigationItem.title = L10n.Cities.title
        
        section.headerHeight = .leastNormalMagnitude
        tableDirector += section
        
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
    }
    
    private func configureTableDirector() {
        section.clear()
        
        let rows = presenter.viewModels.map({
            TableRow<CityTableViewCell>(item: $0).on(.click) { [weak self] options in
                guard let `self` = self else { return }
                self.presenter.cityDidSelect(item: options.item)
            }
        })
        section += rows
        tableDirector.reload()
    }
}

extension CitiesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.search(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CitiesViewController: CitiesViewProtocol {
    
    func updateLoaderState(isLoading: Bool) {
        isLoading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
    }
    
    func reload() {
        configureTableDirector()
    }
}
