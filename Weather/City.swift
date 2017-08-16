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
    
    dynamic var id:       String = ""
    dynamic var key:      String = ""
    dynamic var name:     String = ""
    dynamic var region:   String = ""
    
    override class func primaryKey() -> String? {
        return #keyPath(City.id)
    }
}


extension City {
    
    static func citiesFrom(dict: Any) -> [City] {
        
        guard let jsonDict = dict as? NSDictionary else {
            assertionFailure("Invalid NSDictionary passed to City \(dict)")
            return []
        }

        var cities = [City]()
        guard let jsonArray = JSON(jsonDict)["items"].array else {
            assertionFailure("Invalid JSON \(jsonDict)")
            return []
        }
        
        for citiesJson in jsonArray {
            if let city = City(json: citiesJson) {
                cities.append(city)
            }
        }
        return cities
    }
    
    
    convenience init?(json: JSON) {
        guard let key   = json["Key"].string,
            let name    = json["LocalizedName"].string,
            let region  = json["AdministrativeArea"]["LocalizedName"].string
            else {
                assertionFailure("Invalid JSON \(json)")
                return nil
        }
        self.init()
        self.key = key
        self.name = name
        self.region = region
    }
}
