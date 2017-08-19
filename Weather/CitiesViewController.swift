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
    
    fileprivate var citiesSubscription: NotificationToken!
    fileprivate var cities: Results<City>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCities()
    }
    
    func getCities() {
        cities = WeatherProvider.sharedProvider.getCities()
        citiesSubscription = notificationSubscription(cities: cities)
    }
    
    func notificationSubscription(cities: Results<City>) -> NotificationToken {
        return cities.addNotificationBlock {[weak self] (changes: RealmCollectionChange<Results<City>>) in
            guard let wself = self else { return }
            wself.tableView.reloadData()
        }
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CityTableViewCell.self)
        cell.configureWith(city: cities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CityWeatherViewController") as! CityWeatherViewController
        vc.city = cities[indexPath.row]
        self.show(vc, sender: self)
    }
}
