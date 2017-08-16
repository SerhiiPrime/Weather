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


//MARK - Read/Wride db
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
