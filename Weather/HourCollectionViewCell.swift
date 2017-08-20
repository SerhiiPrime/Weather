//
//  HourCollectionViewCell.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/19/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit
import Kingfisher

class HourCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var prettyDateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    func configureWithHour(hour: Hour) {
        prettyDateLabel.text = hour.prettyName
        temperatureLabel.text = hour.temperature.description
        conditionLabel.text = hour.condition
        
        if let url = URL(string: hour.iconUrl) {
            iconImageView.kf.setImage(with: url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prettyDateLabel.text = nil
        temperatureLabel.text = nil
        conditionLabel.text = nil
    }
}
