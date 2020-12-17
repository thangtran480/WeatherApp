//
//  HomeModel.swift
//  WeatherApp
//
//  Created by CuongNH22 on 12/9/20.
//  Copyright © 2020 Thangtv28. All rights reserved.
//

import Foundation

protocol HomeModelDelegate {
    func didUpdateWeather(weatherReponseData: WeatherResponseData)
}

class HomeModel {
    
    let url: String = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely&appid=27a7df37e78c33a32df2d5ac86d82ede&lang=vi&units=metric"
    var delegate: HomeModelDelegate? = nil
    
    func fetchUrlString(cityName: String) {
        let urlString = "\(url)&q=\(cityName)"
        performWeather(urlString: urlString)
    }
    
    func fetchUrlString(lat: Double, long: Double) {
        let urlString = "\(url)&lat=\(lat)&lon=\(long)&exclude=minutely,alerts"
        performWeather(urlString: urlString)
    }
    func performWeather(urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){(data, urlResponse, error) in
                if (error != nil){
                    return
                }
                if let safeData = data{
                    if let weatherReponseData = self.parseJSON(data: safeData){
                        self.delegate?.didUpdateWeather(weatherReponseData: weatherReponseData)
                    }
                }
            }
            
            task.resume()
        }
    }
    func parseJSON(data: Data) -> WeatherResponseData?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(WeatherResponseData.self, from: data)
                        
            return decodeData
            
        }catch{
            print(error)
            return nil
        }
    }
}
