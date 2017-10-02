//
//  WeatherDetailVC.swift
//  WeatherTestDimaRain
//
//  Created by Anton on 23.09.17.
//  Copyright © 2017 PyroG. All rights reserved.
//

import UIKit

class WeatherDetailVC: UIViewController {

    @IBOutlet weak var currentCityLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var addInfoLableOne: UILabel!
    @IBOutlet weak var addInfoLableTwo: UILabel!
    @IBOutlet weak var addInfoLableThree: UILabel!
    @IBOutlet weak var addInfoLableFour: UILabel!
    @IBOutlet weak var smallDescribtion: UILabel!

    var currentCityDetail = ""
    var dateDetail = ""
    var tempDetail = ""
    var addInfoOneDetail = ""
    var addInfoTwoDetail = ""
    var addInfoThreeDetail = ""
    var addInfoFourDetail = ""
    var addInfoFiveDetail = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        currentCityLable.text = currentCityDetail
        dateLable.text = dateDetail
        tempLable.text = tempDetail
        addInfoLableOne.text = addInfoOneDetail
        addInfoLableTwo.text = addInfoTwoDetail
        addInfoLableThree.text = addInfoThreeDetail
        addInfoLableFour.text = addInfoFourDetail
        smallDescribtion.text = addInfoFiveDetail

    }
}
