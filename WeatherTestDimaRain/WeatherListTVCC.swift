//
//  WeatherListTVCC.swift
//  WeatherTestDimaRain
//
//  Created by Anton on 22.09.17.
//  Copyright © 2017 PyroG. All rights reserved.
//

import UIKit

class WeatherListTVCC: UITableViewCell {

    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var tempLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
