//
//  Date+Extension.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/20/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation

extension Formatter {
    
    static let prettyDayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM dd"
        dateFormatter.doesRelativeDateFormatting = false
        return dateFormatter
    }()
    
    
    static let prettyHourFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a, EEEE"
        dateFormatter.doesRelativeDateFormatting = false
        return dateFormatter
    }()
}


extension Date {
    
    var prettyDayString: String {
        return Formatter.prettyDayFormatter.string(from: self)
    }
    
    var prettyHourString: String {
        return Formatter.prettyHourFormatter.string(from: self)
    }

    static func dateFrom(hour: Int = 0, day: Int, month: Int, year: Int) -> Date? {
        var c = DateComponents()
        c.hour = hour
        c.day = day
        c.month = month
        c.year = year
        return Calendar(identifier: .gregorian).date(from: c)
    }
}

