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
        
        let results = searchBar.rx.text.orEmpty
            .asDriver()
            .throttle(0.3)
            .distinctUntilChanged()
            .flatMapLatest { query in
                
                NetworkManager.sharedManager.getCities(query)
                    .retry(3)
                    .startWith([]) 
                    .asDriver(onErrorJustReturn: [])
        }
        
        results
            .drive(tableView.rx.items(cellIdentifier: CityNameTableViewCell.reuseIdentifier,
                                      cellType: CityNameTableViewCell.self)) { (_, element, cell) in
                cell.textLabel?.text = element.name
                cell.detailTextLabel?.text = element.region
            }
            .disposed(by: disposeBag)
    }
}
