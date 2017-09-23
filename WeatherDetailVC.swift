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
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
