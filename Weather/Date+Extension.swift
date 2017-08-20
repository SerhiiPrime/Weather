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
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }()
    
    
    static let prettyHourFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
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
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    //TODO: DRY
    static func dateFrom(day: Int, month: Int, year: Int) -> Date? {
        var c = DateComponents()
        c.day = day
        c.month = month
        c.year = year
        return Calendar(identifier: .gregorian).date(from: c)
    }
    
    static func dateFrom(hour: Int, day: Int, month: Int, year: Int) -> Date? {
        var c = DateComponents()
        c.hour = hour
        c.day = day
        c.month = month
        c.year = year
        return Calendar(identifier: .gregorian).date(from: c)
    }
}

