//
//  ViewController.swift
//  WeatherApp
//
//  Created by CuongNH22 on 12/9/20.
//  Copyright © 2020 Thangtv28. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    let maxHeaderHeight: CGFloat = 250.0
    let minHeaderHeight: CGFloat = 50.0
    let maxCityNameHeight: CGFloat = 40.0
    let minCityNameHeight: CGFloat = 8.0
    
    @IBOutlet weak var tempWeatherLabel: UILabel!
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var celsiusMax: UILabel!
    @IBOutlet weak var celsiusMin: UILabel!
    @IBOutlet weak var weatherDesLabel: UILabel!
    @IBOutlet weak var tableWeatherDayly: UITableView!
    
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tabelWeatherHourly: UICollectionView!
    @IBOutlet weak var imageAirQualyti: UIImageView!
    @IBOutlet weak var aqiLabel: UILabel!
    @IBOutlet weak var aqiView: UIView!
    @IBOutlet weak var airQualityDesLabel: UILabel!
    @IBOutlet weak var viewAirQuality: UIView!
    @IBOutlet weak var viewWeather: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cityNameLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var uviLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    
    var weatherReponseData: WeatherResponseData? = nil
    var airQualityObj: AirQualityObj? = nil
    var homeModel: HomeModel = HomeModel()
    let locationManager = CLLocationManager()
    private var previousScrollOffset : CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aqiView.layer.cornerRadius = 12
        aqiView.layer.masksToBounds = true
        
        homeModel.delegate = self
        locationManager.delegate = self
        
        tableWeatherDayly.delegate = self
        tableWeatherDayly.dataSource = self
        tableWeatherDayly.register(UINib(nibName: "DailyCell", bundle: nil), forCellReuseIdentifier: "DailyCell")
        
        tabelWeatherHourly.delegate = self
        tabelWeatherHourly.dataSource = self
        tabelWeatherHourly.register(HourlyCell.self, forCellWithReuseIdentifier: "HourlyCell")
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        scrollView.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onCickViewAirQuality(_:)))
        viewAirQuality.addGestureRecognizer(tap)
    }

}

extension HomeViewController: HomeModelDelegate{
    func didUpdateWeather(weatherReponseData: WeatherResponseData) {
        
        self.weatherReponseData = weatherReponseData
        self.tempWeatherLabel.text = String(format: "%.0f", weatherReponseData.current.temp)
        self.weatherDesLabel.text = "\(weatherReponseData.current.weather[0].description)"
        self.sunriseLabel.text = "\(weatherReponseData.current.sunriseTimeString.components(separatedBy: " ")[1])"
        self.sunsetLabel.text = "\(weatherReponseData.current.sunsetTimeString.components(separatedBy: " ")[1])"
        self.humidityLabel.text = "\(weatherReponseData.current.humidity)"
        self.visibilityLabel.text = "\(weatherReponseData.current.visibility)"
        self.uviLabel.text = "\(weatherReponseData.current.uvi)"
        self.feelsLikeLabel.text = String(format: "%.1f", weatherReponseData.current.feels_like)
//        self.uviLabel.text = "\(weatherReponseData.)"
        self.celsiusMax.text = String(format: "%.0f", weatherReponseData.daily[0].temp.max)
        self.celsiusMin.text = String(format: "%.0f", weatherReponseData.daily[0].temp.min)
    
        self.tableWeatherDayly.reloadData()
        self.tabelWeatherHourly.reloadData()
    
    }
    func didUpdateAirQuality(airQualityObj: AirQualityObj){
        self.airQualityObj = airQualityObj
        
        imageAirQualyti.image = UIImage(named: airQualityObj.imageString)
        aqiLabel.text = "\(airQualityObj.aqi)"
        aqiView.backgroundColor = airQualityObj.color
        airQualityDesLabel.text = airQualityObj.status
    }
}

extension HomeViewController{
    @objc func onCickViewAirQuality(_ sender: UITapGestureRecognizer? = nil){
        
        let status: String = self.airQualityObj?.status ?? ""
            
        let description: String = self.airQualityObj?.description ?? ""
        let color: UIColor = self.airQualityObj?.color ?? UIColor.green
        
        let alert = UIAlertController(title: "\(status)", message: "\(description)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            self.homeModel.fetchUrlStringWeather(lat: lat, long: lon)
            self.homeModel.fetchUrlStringAir(lat: lat, long: lon)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DailyCell", for: indexPath) as? DailyCell
        if cell == nil{
            cell = DailyCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "DailyCell")
        }
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        cell?.daily = self.weatherReponseData?.daily[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherReponseData?.daily.count ?? 0
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = (self.weatherReponseData?.hourly.count ?? 0)
        count = count / 2
        return count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCell", for: indexPath) as! HourlyCell
        
        cell.weatherHourly = weatherReponseData?.hourly[indexPath.row]
        
        return cell
    }
}
extension HomeViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let absoluteTop : CGFloat = 0.0
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        
        let scrollDiff = scrollView.contentOffset.y - previousScrollOffset
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        previousScrollOffset = scrollView.contentOffset.y
        
        var newHeight = headerHeightConstraint.constant
        if isScrollingDown{
            newHeight = max(minHeaderHeight, headerHeightConstraint.constant - abs(scrollDiff))
        }else if isScrollingUp{
            newHeight = min(maxHeaderHeight, headerHeightConstraint.constant + abs(scrollDiff))
        }
        
        if newHeight != headerHeightConstraint.constant{
            headerHeightConstraint.constant = newHeight
            setScrollPosition(previousScrollOffset: previousScrollOffset)
            self.updateHeader()
        }
    }
    private func setScrollPosition(previousScrollOffset: CGFloat){
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: previousScrollOffset)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidStopScrolling()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            scrollViewDidStopScrolling()
        }
    }
    
    private func scrollViewDidStopScrolling(){
        let range = maxHeaderHeight - minHeaderHeight
        let midPoint = minHeaderHeight + range / 2
        
        if headerHeightConstraint.constant > midPoint{
            expandHeader()
        }else{
            collapseHeader()
            headerHeightConstraint.constant = minHeaderHeight
        }
    }
    private func collapseHeader(){
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.view.layoutIfNeeded()
            self.updateHeader()
        })
    }
    private func expandHeader(){
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.view.layoutIfNeeded()
            self.updateHeader()
        })
    }
    
    private func updateHeader(){
        let range = maxHeaderHeight - minHeaderHeight
        let  openAmount = headerHeightConstraint.constant - minHeaderHeight
        
        let percentage = openAmount / range

        cityNameLabelConstraint.constant = maxCityNameHeight*percentage + minCityNameHeight
        viewWeather.alpha = percentage
        viewAirQuality.alpha = percentage
        
    }
}

