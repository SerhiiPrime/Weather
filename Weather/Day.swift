//
//  Day.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/19/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Day: Object {
    
    dynamic var maxTemp: Int = 0
    dynamic var minTemp: Int = 0

    dynamic var day:    Int = 0
    dynamic var month:  Int = 0
    
    dynamic var prettyName: String = ""
    dynamic var iconUrl: String = ""
    dynamic var condition: String = ""
}


extension Day {
    
    static func daysFrom(dict: Any) -> [Day] {
        
        guard let jsonArray = JSON(object: dict)["forecast"]["simpleforecast"]["forecastday"].array else {
            assertionFailure("Invalid JSON \(dict)")
            return []
        }
        
        var days = [Day]()
        
        for daysJson in jsonArray {
            if let day = Day(json: daysJson) {
                days.append(day)
            }
        }
        return days
    }
    
    
    convenience init?(json: JSON) {
        guard
            let maxTempStr  = json["high"]["celsius"].string,
            let maxTemp     = Int(maxTempStr),
            
            let minTempStr  = json["low"]["celsius"].string,
            let minTemp     = Int(minTempStr),
            
            let day         = json["date"]["day"].int,
            let month       = json["date"]["month"].int,

            let prettyDay   = json["date"]["weekday"].string,
            let prettyMonth = json["date"]["monthname_short"].string,
            let iconUrl     = json["icon_url"].string,
            let condition   = json["conditions"].string
            else {
                assertionFailure("Invalid JSON \(json)")
                return nil
        }
        self.init()
        self.maxTemp    = maxTemp
        self.minTemp    = minTemp
        self.day        = day
        self.month      = month
        self.prettyName = "\(prettyDay), \(day) \(prettyMonth)"
        self.iconUrl    = iconUrl
        self.condition  = condition
    }
}
