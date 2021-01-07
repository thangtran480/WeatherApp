//
//  HomeModel.swift
//  WeatherApp
//
//  Created by CuongNH22 on 12/9/20.
//  Copyright © 2020 Thangtv28. All rights reserved.
//

import Foundation
import Alamofire

protocol HomeModelDelegate {
    func didUpdateWeather(weatherReponseData: WeatherResponseData)
    func didUpdateAirQuality(airQualityObj: AirQualityObj)
}

class HomeModel {
    
    var delegate: HomeModelDelegate? = nil
    
    func fetchUrlStringWeather(cityName: String) {
        let urlString = "\(URL_OPENWEATHERMAP)&q=\(cityName)"
        performWeather(urlString: urlString)
    }
    
    func fetchUrlStringWeather(lat: Double, long: Double) {
        let urlString = "\(URL_OPENWEATHERMAP)&lat=\(lat)&lon=\(long)&exclude=minutely,alerts"
        performWeather(urlString: urlString)
    }
    func performWeather(urlString: String) {
        Alamofire.request(urlString, method: .get)
            .responseData { response in
                let statusCode = response.response?.statusCode ?? 0
                switch statusCode{
                case 200:
                    if let data = response.data {
                        let weatherReponseData = try? JSONDecoder().decode(WeatherResponseData.self, from: data)
                        if weatherReponseData != nil{
                            self.delegate?.didUpdateWeather(weatherReponseData: weatherReponseData!)
                        }
                    }
                    break
                default: break
                }
            }
    }
    
    func fetchUrlStringAir(cityName: String) {
        let urlString = String(format: URL_AIRQUALITY, cityName)
        print(urlString)
    }
    
    func fetchUrlStringAir(lat: Double, long: Double){
        let content = "geo:\(lat);\(long)"
        let urlString = String(format: URL_AIRQUALITY, content)
        performAirQuality(urlString: urlString)
    }
    
    func performAirQuality(urlString: String){
        Alamofire.request(urlString, method: .get)
            .responseJSON { response in
                let statusCode = response.response?.statusCode ?? 0
                switch statusCode{
                case 200:
                    if let result = response.result.value as? NSDictionary{
                        let data = result.object(forKey: "data") as! NSDictionary
                        let aqi = data.object(forKey: "aqi") as! Int
                        let airQualityObj = AirQualityObj(aqi: aqi)
                        self.delegate?.didUpdateAirQuality(airQualityObj: airQualityObj)
                    }
                    break
                default: break
                }
            }
    }
}
