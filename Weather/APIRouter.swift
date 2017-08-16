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
        static let APPID = "ULMcvG42cWCi7A57ToiE9MbBJvHFVUNZ"
        static let baseURL = "http://dataservice.accuweather.com/locations/v1"
    }

    case getCities(String)

    var method: HTTPMethod{
        switch self {
        case .getCities:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getCities:
            return "/cities/autocomplete"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getCities(let query):
            return ["q": query]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getCities:
            return URLEncoding.default
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.Constants.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        var paramsWithId = parameters ?? [:]
        paramsWithId["apikey"] = APIRouter.Constants.APPID
        
        return try encoding.encode(urlRequest, with: paramsWithId)
    }
}
