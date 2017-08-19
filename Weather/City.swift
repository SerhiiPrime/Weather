//
//  City.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/15/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON


class City: Object {
    
    dynamic var key:      String = ""
    dynamic var name:     String = ""
    
    override class func primaryKey() -> String? {
        return #keyPath(City.key)
    }
}


extension City {
    
    static func citiesFrom(dict: Any) -> [City] {

        guard let jsonArray = JSON(object: dict)["RESULTS"].array else {
            assertionFailure("Invalid JSON \(dict)")
            return []
        }
        
        var cities = [City]()
        
        for citiesJson in jsonArray {
            if let city = City(json: citiesJson) {
                cities.append(city)
            }
        }
        return cities
    }
    
    
    convenience init?(json: JSON) {
        guard let key   = json["zmw"].string,
            let name    = json["name"].string
            else {
                assertionFailure("Invalid JSON \(json)")
                return nil
        }
        self.init()
        self.key = key
        self.name = name
    }
}
