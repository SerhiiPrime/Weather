//
//  Request .swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/19/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    
    public func logRequest() -> Self {
        debugPrint(self)
        return self
    }
}
