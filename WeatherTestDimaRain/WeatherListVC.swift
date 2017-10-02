//
//  WeatherListVC.swift
//  WeatherTestDimaRain
//
//  Created by Anton on 22.09.17.
//  Copyright © 2017 PyroG. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherListVC: UIViewController, UITableViewDataSource,UITableViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indi: UIActivityIndicatorView!

   //some comments for git test 1
    var manager: CLLocationManager!
    let weatherProvider = WeatherProvider()
    var currentCity = ""
    var date = ""
    var temp = ""
    var addInfoOne = ""
    var addInfoTwo = ""
    var addInfoThree = ""
    var addInfoFour = ""
    var addInfoFive = ""
    
    
    var locationContainer = [CLLocation]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        indi.startAnimating()
        indi.isHidden = false
        manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.distanceFilter = 1000.0
        manager.startUpdatingLocation()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        
        let userLocation:CLLocation = locations[0]
        print("did update location")
        let lat = userLocation.coordinate.latitude
        let lon = userLocation.coordinate.longitude
        weatherProvider.getWeatherByCurrentLocation(lat: lat, lon: lon, activityInd: indi, tableDel: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherProvider.weatherListContainer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeatherListTVCC
        let weatherExample = weatherProvider.weatherListContainer[indexPath.row]
        let kelvin = (weatherExample.main?.value(forKey: "temp")) as! Double
        let kelvinToCelsius = weatherProvider.celsiumTempConverter(kelvin)
        let dateFormatted = weatherProvider.dateFormatterFunc(weatherExample.dt as! Double)
        
        cell.cityLable.text = "\(weatherProvider.cityName)" 
        cell.dateLable.text = "Дата: "+"\(dateFormatted )"
        cell.tempLable.text = "Температура воздуха: \(kelvinToCelsius)°C"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = weatherProvider.weatherListContainer[indexPath.row]
        let kelvin = (row.main?.value(forKey: "temp")) as! Double
        let kelvinToCelsius = weatherProvider.celsiumTempConverter(kelvin)
        let windDirection = weatherProvider.windDirectionFormatter((row.wind?.value(forKey: "deg") as! Double))
        let windSpeed = row.wind?.value(forKey: "speed") as! Float
        let dateFormatted = weatherProvider.dateFormatterFunc(row.dt as! Double)
        
        currentCity = weatherProvider.cityName
        date = "\(dateFormatted)"
        temp = "\(kelvinToCelsius)°C"
        
        addInfoOne = "Отн.влажность: \(row.main?.value(forKey: "humidity") ?? "хх")%"
        addInfoTwo = "Атм.давление: \(row.main?.value(forKey: "pressure") ?? "хх") мм.рт.ст"
        addInfoThree = "Ветер: \(windDirection), \(windSpeed)м/с."
        addInfoFour = "Облачность: \(row.clouds?.value(forKey: "all") ?? "хх")%"
        addInfoFive = "\(row.weather?.value(forKey: "description") ?? "Не стабильно")"
        performSegue(withIdentifier: "detail", sender: nil)

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let vc = segue.destination as! WeatherDetailVC
            vc.currentCityDetail = weatherProvider.cityName
            vc.dateDetail = date
            vc.tempDetail = temp
            vc.addInfoOneDetail = addInfoOne
            vc.addInfoTwoDetail = addInfoTwo
            vc.addInfoThreeDetail = addInfoThree
            vc.addInfoFourDetail = addInfoFour
            vc.addInfoFiveDetail = addInfoFive
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
