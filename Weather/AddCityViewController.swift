//
//  AddCityViewController.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/16/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        configureTableDataSource()
    }
    
    func configureTableDataSource() {
        
        // Search cities
        let results = searchBar.rx.text.orEmpty
            .asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query in
                
                NetworkManager.sharedManager.getCities(query)
                    .retry(3)
                    .startWith([])
                    .asDriver(onErrorJustReturn: [])
        }
        
        // Populate table view
        results.bind(to: tableView.rx.items(cellIdentifier: CityNameTableViewCell.reuseIdentifier,
                                            cellType: CityNameTableViewCell.self)) { (_, city, cell) in
                                                
                                                cell.configureWith(city: city)
            }
            .addDisposableTo(disposeBag)
        
        
        // Save selected city
        tableView.rx.modelSelected(City.self)
            .subscribe(onNext: { [weak self] city in
                
                WeatherProvider.sharedProvider.saveCityToDB(city: city)
                self?.navigationController?.popViewController(animated: true)
            })
            .addDisposableTo(disposeBag)
    }
}
