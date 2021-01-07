//
//  WeatherResponseData.swift
//  WeatherApp
//
//  Created by CuongNH22 on 12/9/20.
//  Copyright © 2020 Thangtv28. All rights reserved.
//

import Foundation

struct WeatherResponseData: Decodable {
    let current: WeatherObj
    let daily: [WeatherDailyObj]
    let hourly: [WeatherHourlyObj]

}
