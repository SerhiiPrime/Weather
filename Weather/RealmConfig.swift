//
//  RealmConfig.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/15/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmConfig {
    
    private static let schemaVersion: UInt64 = 1
    
    private static var copyInitialFile: Void = {
        FileManager.copyInitialData(
            Bundle.main.url(forResource: "default_v1.0", withExtension: "realm")!,
            to: RealmConfig.weatherConfig.fileURL!)
    }()
    
    private static let weatherConfig = Realm.Configuration.init(fileURL: URL.inDocumentsFolder("weather.realm"),
                                                                schemaVersion: schemaVersion)
    

    var configuration: Realm.Configuration {
        switch self {
        case .weather:
            _ = RealmConfig.copyInitialFile
            return RealmConfig.weatherConfig
        }
    }
    
    case weather
}
