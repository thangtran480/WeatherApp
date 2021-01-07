//
//  WeatherObj.swift
//  WeatherApp
//
//  Created by CuongNH22 on 12/9/20.
//  Copyright © 2020 Thangtv28. All rights reserved.
//

import Foundation

struct WeatherObj : Decodable{
    let temp: Double
    let weather: [Weather]
    let clouds: Double
    let humidity: Double
    let sunrise: Int
    let sunset: Int
    let wind_speed: Double
    let visibility: Int
    let uvi: Double
    let feels_like: Double
    var sunriseTimeString: String{
        return Utils.getTime(time: sunrise)
    }
    var sunsetTimeString: String{
        return Utils.getTime(time: sunset)
    }
}

struct WeatherHourlyObj : Decodable{
    let dt: Int
    let temp: Double
    let weather: [Weather]
    var timeString: String {
        return  Utils.getTime(time: dt)
    }
    var conditionName: String{
        return weather[0].conditionName
    }
}

struct WeatherDailyObj: Decodable {
    let dt: Int
    let sunset: Int
    let sunrise: Int
    let temp: Temp
    let weather: [Weather]
    
    var timeString: String {
        return  Utils.getTime(time: dt)
    }
    var conditionName: String{
        return weather[0].conditionName
    }
}
struct Weather: Decodable {
    let id: Int
    let description: String
    let main: String
    var conditionName: String {
        switch self.id {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle"
        case 500...504:
            return "cloud.rain"
        case 511:
            return "cloud.snow"
        case 511...531:
            return "cloud.heavyrain.fill"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801:
            return "cloud.sun"
        case 802:
            return "cloud"
        case 803, 804:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }
}
struct Temp : Decodable{
    let day: Double
    let min: Double
    let max: Double
    let night: Double
}
