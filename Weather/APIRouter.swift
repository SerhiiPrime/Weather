//
//  APIRouter.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/15/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import Alamofire


enum APIRouter: URLRequestConvertible {
    
    private struct Constants {
        static let key = "591ef5c5fa1dfa49"
        static let baseURL = "http://api.wunderground.com/api/"
        static let autocompleteURL = "http://autocomplete.wunderground.com/"
    }

    
    case getCities(query: String)
    case getHourlyWeather(cityId: String)
    case getDailyWeather(cityId: String)
    
    var url: String{
        switch self {
        case .getCities:
            return APIRouter.Constants.autocompleteURL
            
        case .getHourlyWeather,
             .getDailyWeather:
            return APIRouter.Constants.baseURL + "/" + APIRouter.Constants.key
        }
    }

    var method: HTTPMethod{
        switch self {
        case .getCities,
             .getHourlyWeather,
             .getDailyWeather:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getCities:
            return "aq"
            
        case .getHourlyWeather(let cityId):
            return "/hourly/q/zmw:\(cityId).json"
            
        case .getDailyWeather(let cityId):
            return "/forecast10day/q/zmw:\(cityId).json"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getCities(let query):
            return ["query": query]
            
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getCities,
             .getHourlyWeather,
             .getDailyWeather:
            return URLEncoding.default
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try self.url.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        return try encoding.encode(urlRequest, with: parameters)
    }
}
