//
//  HourlyCell.swift
//  WeatherApp
//
//  Created by CuongNH22 on 12/9/20.
//  Copyright © 2020 Thangtv28. All rights reserved.
//

import Foundation
import UIKit

class HourlyCell : UICollectionViewCell {
    
    var weatherHourly: WeatherHourlyObj? = nil
    
    var timeLabel: UILabel = UILabel()
    var imageWeatherImageView: UIImageView = UIImageView()
    var tempLabel : UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        timeLabel.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageWeatherImageView.frame = CGRect(x: self.frame.width/2 - 30, y: self.frame.height/2-30, width: 30, height: 30)
        tempLabel.frame = CGRect(x: 0, y: self.frame.height-30, width: self.frame.width, height: 30)
        
        self.addSubview(timeLabel)
        self.addSubview(imageWeatherImageView)
        self.addSubview(tempLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        imageWeatherImageView.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            timeLabel.widthAnchor.constraint(equalToConstant: 30),
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
//            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            imageWeatherImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            imageWeatherImageView.widthAnchor.constraint(equalToConstant: 30),
            imageWeatherImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageWeatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            tempLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        timeLabel.textAlignment = .center
        timeLabel.textColor = .white
        tempLabel.textAlignment = .center
        tempLabel.textColor = .white
        imageWeatherImageView.tintColor = .white
    }
    
    override func layoutSubviews() {
        timeLabel.text = weatherHourly?.timeString.components(separatedBy: " ")[1].components(separatedBy: ":")[0]
        
        tempLabel.text = String(format: "%.0f", weatherHourly?.temp ?? -1)
        
        imageWeatherImageView.image = UIImage(systemName: weatherHourly?.conditionName ?? "sun.max")
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
