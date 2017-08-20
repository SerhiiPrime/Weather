//
//  WeatherProvider.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/16/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherProvider {
    
    fileprivate let realmWeather = try! Realm(configuration: RealmConfig.weather.configuration)
    
    static let sharedProvider = WeatherProvider()
    
    private init() {}
}


//MARK - CITY
//
extension WeatherProvider {
    
    func getCities() -> Results<City> {
        return realmWeather.objects(City.self)
    }
    
    func saveCityToDB(city: City, withoutNotifying tokens: [NotificationToken] = []) {
        realmWeather.beginWrite()
        realmWeather.add(city, update: true)
        try! realmWeather.commitWrite(withoutNotifying: tokens)
    }
}


//MARK - WEATHER
//
extension WeatherProvider {
    
     func saveHoursToDB(hours: [Hour], forCity city: City) {
        realmWeather.beginWrite()
        
        city.hourly.removeAll()
        city.hourly.append(objectsIn: hours)
        
        try! realmWeather.commitWrite()
    }
    
    func saveDaysToDB(days: [Day], forCity city: City) {
        realmWeather.beginWrite()
        
        city.dayly.removeAll()
        city.dayly.append(objectsIn: days)
        
        try! realmWeather.commitWrite()
    }
}
