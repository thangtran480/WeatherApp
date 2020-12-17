//
//  Utils.swift
//  WeatherApp
//
//  Created by CuongNH22 on 12/9/20.
//  Copyright © 2020 Thangtv28. All rights reserved.
//

import Foundation
class Utils {
    static func getTime(time: Int) -> String{
        let date = Date(timeIntervalSince1970: Double(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm EEEE"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}
