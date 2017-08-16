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


enum ErrorCode: Int {
    case noNetwork            = -1009
    case sessionExpired       = 401
    case clientError          = 500
    case unknownError         = 1000
    case unexpectedJsonValue  = 1001
    case closeSocketByClient  = 0
}


struct NetworkError: Swift.Error {
    let code: ErrorCode
    let message: String
    
    init(code: ErrorCode) {
        self.init(code: code, message: "Error")
    }
    
    init(code: ErrorCode, message: String) {
        self.code = code
        self.message = message
    }
    
    init(error: Swift.Error) {
        
        var code = (error as NSError).code
        if let errorAF = error as? AFError, let errorCode = errorAF.responseCode {
            code = errorCode
        }
        
        self.code = ErrorCode(rawValue: code) ?? .unknownError
        self.message = error.localizedDescription
    }
}


class NetworkManager {
    
    static let sharedManager = NetworkManager()
    private let networkManager: SessionManager!

    private init() {
        networkManager = Alamofire.SessionManager.default
    }

    
    func getCities(_ query: String) -> Observable<[City]> {
        
        return Observable<[City]>.create { (observer) -> Disposable in
            let request = self.networkManager
                .request(APIRouter.getCities(query))
                .validate()
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let dict):
                        let cities = City.citiesFrom(dict: dict)
                        observer.onNext(cities)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        observer.onError(NetworkError(error: error))
                    }
            }
            return Disposables.create { request.cancel() }
        }
    }
}
