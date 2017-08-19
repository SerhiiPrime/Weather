//
//  Hour.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/19/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Hour: Object {
    
    dynamic var temperature: Int = 0
    dynamic var hour: Int = 0
    dynamic var day: Int = 0
    
    dynamic var prettyName: String = ""
    dynamic var iconUrl: String = ""
    dynamic var condition: String = ""
}


extension Hour {
    
    static func hoursFrom(dict: Any) -> [Hour] {
        
        guard let jsonArray = JSON(object: dict)["hourly_forecast"].array else {
            assertionFailure("Invalid JSON \(dict)")
            return []
        }
        
        var hours = [Hour]()
        
        for hoursJson in jsonArray {
            if let hour = Hour(json: hoursJson) {
                hours.append(hour)
            }
        }
        return hours
    }
    
    
    convenience init?(json: JSON) {
        guard
            let tempStr     = json["temp"]["metric"].string,
            let temp        = Int(tempStr),
            
            let hourStr     = json["FCTTIME"]["hour"].string,
            let hour        = Int(hourStr),
            
            let dayStr      = json["FCTTIME"]["mday"].string,
            let day         = Int(dayStr),
        
            let prettyHour  = json["FCTTIME"]["civil"].string,
            let prettyDay   = json["FCTTIME"]["weekday_name"].string,
            let iconUrl     = json["icon_url"].string,
            let condition   = json["wx"].string
            else {
                assertionFailure("Invalid JSON \(json)")
                return nil
        }
        self.init()
        self.temperature    = temp
        self.hour           = hour
        self.day            = day
        self.prettyName     = "\(prettyHour), \(prettyDay)"
        self.iconUrl        = iconUrl
        self.condition      = condition
    }
}
