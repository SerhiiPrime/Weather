//
//  ViewController.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/15/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit
import RealmSwift

class CitiesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var cities: Results<City>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm(configuration: RealmConfig.weather.configuration)
        cities = realm.objects(City.self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CityTableViewCell.self)
        let city = cities[indexPath.row]
        cell.cityNameLabel.text = city.name
        return cell
    }
}
