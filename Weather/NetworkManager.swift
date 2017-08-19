//
//  NetworkManager.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/15/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RxSwift


class NetworkManager {
    
    static let sharedManager = NetworkManager()
    private let networkManager: SessionManager!

    private init() {
        networkManager = Alamofire.SessionManager.default
    }

    
    func getCities(_ query: String) -> Observable<[City]> {
        
        return Observable<[City]>.create { (observer) -> Disposable in
            let request = self.networkManager
                .request(APIRouter.getCities(query: query))
                .logRequest()
                .validate()
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let dict):
                        observer.onNext(City.citiesFrom(dict: dict))
                        observer.onCompleted()
                        
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create { request.cancel() }
        }
    }
    
    func getHourlyWeather(_ cityId: String) -> Observable<[Hour]> {
        
        return Observable<[Hour]>.create { (observer) -> Disposable in
            let request = self.networkManager
                .request(APIRouter.getHourlyWeather(cityId: cityId))
                .logRequest()
                .validate()
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let dict):
                        observer.onNext(Hour.hoursFrom(dict: dict))
                        observer.onCompleted()
                        
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create { request.cancel() }
        }
    }
    
    func getDailyWeather(_ cityId: String) -> Observable<[Day]> {
        
        return Observable<[Day]>.create { (observer) -> Disposable in
            let request = self.networkManager
                .request(APIRouter.getDailyWeather(cityId: cityId))
                .logRequest()
                .validate()
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let dict):
                        observer.onNext(Day.daysFrom(dict: dict))
                        observer.onCompleted()
                        
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create { request.cancel() }
        }
    }
}
