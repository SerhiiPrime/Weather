//
//  CityWeatherViewController.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/15/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class CityWeatherViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private let disposeBag = DisposeBag()
    
    var city: City!
    var items: [Hour] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        
        NetworkManager.sharedManager.getHourlyWeather(city.key)
        .retry(3)
        .subscribe(onNext: { [weak self] hours in
            self?.items = hours
            self?.collectionView.reloadData()
            
        })
        .addDisposableTo(disposeBag)
    }

    @IBAction func swiftTimelineAction(_ sender: UISegmentedControl) {
        
    }

}


extension CityWeatherViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.reuseIdentifier, for: indexPath) as! HourCollectionViewCell
        cell.configureHour(hour: items[indexPath.row])
        return cell
    }
}
