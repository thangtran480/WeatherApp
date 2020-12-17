//
//  DailyCell.swift
//  WeatherApp
//
//  Created by CuongNH22 on 12/9/20.
//  Copyright © 2020 Thangtv28. All rights reserved.
//

import Foundation
import UIKit

class DailyCell: UITableViewCell {
    var daily: WeatherDailyObj? = nil
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ivWeather: UIImageView!
    @IBOutlet weak var tempHighLabel: UILabel!
    @IBOutlet weak var tempLowLabel: UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clear
        timeLabel.text = daily?.timeString.components(separatedBy: " ")[2]
        tempHighLabel.text = String(format: "%.0f", (daily?.temp.max ?? -1))
        tempLowLabel.text = String(format: "%.0f", (daily?.temp.min ?? -1))
        ivWeather.image = UIImage(systemName: daily?.conditionName ?? "sun.max")
    }
}
