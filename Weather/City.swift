//
//  City.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/15/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RealmSwift

class City: Object {
    
    dynamic var id:     String = ""
    dynamic var name:   String = ""
    
    override class func primaryKey() -> String? {
        return #keyPath(City.id)
    }
    
}
