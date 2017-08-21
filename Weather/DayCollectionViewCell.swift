//
//  DayCollectionViewCell.swift
//  Weather
//
//  Created by Serhii Onopriienko on 8/19/17.
//  Copyright © 2017 Serhii Onopriienko. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var nightTempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    
    
    func configureWithDay(day: Day) {
        dateLabel.text = day.date.prettyHourString
        dayTempLabel.text = day.maxTemp.description
        nightTempLabel.text = day.minTemp.description
        conditionLabel.text = day.condition
        
        if let url = URL(string: day.iconUrl) {
            conditionImageView.kf.setImage(with: url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        dayTempLabel.text = nil
        nightTempLabel.text = nil
        conditionLabel.text = nil
        conditionImageView.image = nil
    }
}
