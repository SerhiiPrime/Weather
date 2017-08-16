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
                    .startWith([]) // clears results on new search term
                    .asDriver(onErrorJustReturn: [])
        }
        
        results
            .drive(tableView.rx.items(cellIdentifier: "CityNameTableViewCell", cellType: CityNameTableViewCell.self)) { (_, viewModel, cell) in
                cell.textLabel?.text = "aaa"
            }
            .disposed(by: disposeBag)
        
    }
}
