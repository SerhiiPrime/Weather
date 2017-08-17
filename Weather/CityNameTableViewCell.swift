//
//  CityNameTableViewCell.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/16/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

class CityNameTableViewCell: UITableViewCell {
    
    func configureWith(city: City) {
        textLabel?.text = city.name
        detailTextLabel?.text = city.region
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }
}
