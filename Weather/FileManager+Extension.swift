//
//  File.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/15/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import RealmSwift

extension FileManager {
    
    static func copyInitialData(_ from: URL, to: URL) {
        let copy = {
            _ = try? FileManager.default.removeItem(at: to)
            try! FileManager.default.copyItem(at: from, to: to)
        }
        
        let exists: Bool
        do {
            exists = try to.checkPromisedItemIsReachable()
        } catch {
            copy()
            return
        }
        if !exists {
            copy()
        }
    }

}
