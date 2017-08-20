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
import Charts


class CityWeatherViewController: UIViewController {
    
    enum SegmentSelectedIndex: Int {
        case hourly
        case dayly
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var lineChartView: LineChartView!
    
    private var hourlyDisposeBag = DisposeBag()
    private var daylyDisposeBag = DisposeBag()
    
    var viewModel: CityWeatherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.cityName
        subscribeHourly()
    }
    
    func subscribeHourly() {
        viewModel.hoursDriver
            .drive(self.collectionView.rx.items(cellIdentifier: HourCollectionViewCell.reuseIdentifier, cellType: HourCollectionViewCell.self)) { (_, hour, cell) in
                cell.configureWithHour(hour: hour)
            }
            .disposed(by: hourlyDisposeBag)
        
        viewModel.hoursChartDataDriver
            .drive(onNext: { [weak self] data in
                self?.lineChartView.data = data
            })
            .disposed(by: hourlyDisposeBag)
    }
    
    func subscribeDayly() {
        viewModel.daysDriver
            .drive(self.collectionView.rx.items(cellIdentifier: DayCollectionViewCell.reuseIdentifier, cellType: DayCollectionViewCell.self)) { (_, day, cell) in
                cell.configureWithDay(day: day)
            }
            .disposed(by: daylyDisposeBag)
        
        viewModel.daysChartDataDriver
            .drive(onNext: { [weak self] data in
                self?.lineChartView.data = data
            })
            .disposed(by: daylyDisposeBag)
    }

    
    @IBAction func swiftTimelineAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == SegmentSelectedIndex.dayly.rawValue {
            hourlyDisposeBag = DisposeBag()
            subscribeDayly()
        } else {
            daylyDisposeBag = DisposeBag()
            subscribeHourly()
        }
    }
}

