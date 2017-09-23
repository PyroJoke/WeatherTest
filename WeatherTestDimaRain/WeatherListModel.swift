//
//  WeatherListModel.swift
//  WeatherTestDimaRain
//
//  Created by Anton on 22.09.17.
//  Copyright © 2017 PyroG. All rights reserved.
//
import UIKit
import Foundation
import CoreLocation

class WeatherProvider {
    
    fileprivate let apiUrl = "http://api.openweathermap.org/data/2.5/forecast?"
    fileprivate var weatherStructureExample: WeatherStructure?
    struct WeatherStructure {
        let dt: NSNumber?
        let main: NSDictionary?
        let weather: NSDictionary?
        let clouds: NSDictionary?
        let wind: NSDictionary?
        let dtTxt: String?
        var shortDate: String {
            get {
                let weatherPostedDate = NSDate(timeIntervalSince1970: dt! as! Double)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                dateFormatter.timeStyle = .none
                dateFormatter.locale = Locale(identifier: "RUS")
                let time = dateFormatter.string(from: weatherPostedDate as Date)
                return time
            }
        }
    }
         var cityName = ""
    var weatherListContainer = [WeatherStructure]()
    var weatherList2: [String:Any] {
        get {
                let weatherListToDict = weatherListContainer.toDictionary {$0.shortDate}
            
                return weatherListToDict
            }
    }
  
    func dateFormatterFunc (_ date: Double) -> String {
        let weatherPostedDate = NSDate(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "RUS")
        let time = dateFormatter.string(from: weatherPostedDate as Date)
        return time
    }

    
    func celsiumTempConverter (_ temp:Double) -> Int {
        let celsiumToFahrenheit = UnitConverterLinear(coefficient: 1.0, constant: 273.15)
        let temperature = UnitTemperature(symbol: "°C", converter: celsiumToFahrenheit)
        let convertedtemperature = temperature.converter.value(fromBaseUnitValue: temp)
        return Int(convertedtemperature)
    }
    
    func windDirectionFormatter (_ degree: Double) -> String {
        let intDegree = Int(degree)
        switch intDegree {
        case 0...15, 346...360:
            return "Северный"
        case 16...75:
            return "Северо-восточный"
        case 76...105:
            return "Восточный"
        case 106...165:
            return "Юго-Восточный"
        case 166...195:
            return "Южный"
        case 196...255:
            return "Юго-Западный"
        case 286...345:
            return "Западный"
        case 286...345:
            return "Северо-Западный"
        default:
            return "отсутствует"
        }
    }
    
    func getWeatherByCurrentLocation (lat:CLLocationDegrees, lon: CLLocationDegrees, activityInd: UIActivityIndicatorView, tableDel: WeatherListVC) {
        
        let url = URL(string: apiUrl+"lat=\(lat)&lon=\(lon)&lang=ru&APPID=298fc32a6da9a2fab38eed6a9bae03d0")
        
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print(url ?? "url Default")
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    //print(json)
                
                    let weatherResponseArray = json["list"] as! NSArray
                    let cityInfoResponseDict = json["city"] as! NSDictionary
                    let city = "\(cityInfoResponseDict.value(forKey: "name") ?? "Неизвестная локация")"
                    self.cityName = city
                    self.weatherListContainer.removeAll()
                    for weather in weatherResponseArray {
                        let weatherExample = weather as! NSDictionary
                        let dtConverted = weatherExample.value(forKey: "dt")
                        let mainConverted = weatherExample.value(forKey: "main") as! NSDictionary
                        let weatherConvertedArray = weatherExample.value(forKey: "weather") as! NSArray
                        let weatherConvertedFinal = weatherConvertedArray[0] as! NSDictionary
                        let cloudsConverted = weatherExample.value(forKey: "clouds") as! NSDictionary
                        let windConverted = weatherExample.value(forKey: "wind") as! NSDictionary
                        let dtTxtConverted = weatherExample.value(forKey: "dt_txt")
                        
                        self.weatherListContainer.append(WeatherStructure(dt:(dtConverted as! NSNumber),
                                                                            main: mainConverted,
                                                                            weather: weatherConvertedFinal,
                                                                          clouds: cloudsConverted,
                                                                          wind: windConverted,
                                                                          dtTxt: "\(dtTxtConverted ?? "haven't convertded")"))
                        
                    
                    
                    }
                    print(self.weatherListContainer)
                    //print(self.weatherListContainer.count)
                    //print(self.weatherList2)
            
                    DispatchQueue.main.async {
                        tableDel.tableView.reloadData()
                        activityInd.stopAnimating()
                    }
                    
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
    }
    

    
}
extension Array {
    mutating func toDictionary<Key:Hashable> (with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
       // var newAr = [Element]()
        for element in self {
            //newAr.append(element)
            
            dict[selectKey(element)] = element
        }
        return dict
    }
}
