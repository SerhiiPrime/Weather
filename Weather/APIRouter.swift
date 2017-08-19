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
    
    // Mdliudty1Xrtsd9CKEHZfnGgpGcqRxDG
    // ULMcvG42cWCi7A57ToiE9MbBJvHFVUNZ
    
    //APIXU
    //acce31c9693d48f5b27100155171908
    
    
    //wunderground
    //591ef5c5fa1dfa49
    
//    private struct Constants {
//        static let APPID = "Mdliudty1Xrtsd9CKEHZfnGgpGcqRxDG"
//        static let baseURL = "http://dataservice.accuweather.com/locations/v1"
//    }

    private struct Constants {
        static let key = "591ef5c5fa1dfa49"
        static let baseURL = "http://autocomplete.wunderground.com/"
        static let autocompleteURL = "http://autocomplete.wunderground.com/"
    }

    
    case getCities(String)
    
    var url: String{
        switch self {
        case .getCities:
            return APIRouter.Constants.autocompleteURL
        }
    }

    var method: HTTPMethod{
        switch self {
        case .getCities:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getCities:
            return "aq"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getCities(let query):
            return ["query": query]
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
        let url = try self.url.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        return try encoding.encode(urlRequest, with: parameters)
    }
}
