//
//  CityWeatherViewModel.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/20/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Charts

final class CityWeatherViewModel {
    
    private let disposeBag = DisposeBag()
    private let city: City!
    
    private let hours: Variable<[Hour]> = Variable([])
    private let days: Variable<[Day]>   = Variable([])
    private let hoursChartData: Variable<LineChartData>  = Variable(LineChartData())
    private let daysChartData: Variable<LineChartData>   = Variable(LineChartData())
    
    var hoursDriver: Driver<[Hour]> {
        return hours.asDriver()
    }
    
    var daysDriver: Driver<[Day]> {
        return days.asDriver()
    }
    
    var hoursChartDataDriver: Driver<LineChartData> {
        return hoursChartData.asDriver()
    }
    
    var daysChartDataDriver: Driver<LineChartData> {
        return daysChartData.asDriver()
    }
    
    var cityName: String {
        return city.name
    }
    
    init(city: City) {
        self.city = city
        loadHourlyData()
        loadDaylyData()
        subscribeChart()
    }
    
    func loadHourlyData() {
        hours.value = Array(city.hourly)
        
//        NetworkManager.sharedManager.getHourlyWeather(city.key)
//            .retry(3)
//            .subscribe(onNext: { [weak self] hours in
//                guard let wself = self else { return }
//                wself.hours.value = hours
//                WeatherProvider.sharedProvider.saveHoursToDB(hours: hours, forCity: wself.city)
//            })
//            .addDisposableTo(disposeBag)
    }
    
    func loadDaylyData() {
        days.value = Array(city.dayly)
        
//        NetworkManager.sharedManager.getDailyWeather(city.key)
//            .retry(3)
//            .subscribe(onNext: { [weak self] days in
//                guard let wself = self else { return }
//                wself.days.value = days
//                WeatherProvider.sharedProvider.saveDaysToDB(days: days, forCity: wself.city)
//            })
//            .addDisposableTo(disposeBag)
    }
    
    func subscribeChart() {
        hoursDriver
            .drive(onNext: { [weak self] data in
                guard let wself = self else { return }
                wself.hoursChartData.value = wself.hoursLineChartData()
            })
            .disposed(by: disposeBag)
        
        daysDriver
            .drive(onNext: { [weak self] data in
                guard let wself = self else { return }
                wself.daysChartData.value = wself.daysLineChartData()
            })
            .disposed(by: disposeBag)
    }
    
    func hoursLineChartData() -> LineChartData {
        var lineChartEntry  = [ChartDataEntry]()
        
        
        for i in 0..<hours.value.count {
            
            let value = ChartDataEntry(x: Double(hours.value[i].date.timeIntervalSince1970), y: Double(hours.value[i].temperature))
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Temperature")
        line1.colors = [NSUIColor.blue]
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        return data
    }
    
    func daysLineChartData() -> LineChartData {
        var lineChartEntry  = [ChartDataEntry]() 
        
        for i in 0..<days.value.count {
            
            let value = ChartDataEntry(x: Double(days.value[i].date.timeIntervalSince1970), y: Double(days.value[i].maxTemp))
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Temperature")
        line1.colors = [NSUIColor.blue]
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        return data
    }
}
