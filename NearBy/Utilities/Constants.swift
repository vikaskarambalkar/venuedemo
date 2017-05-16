//
//  Constants.swift
//  NearBy
//
//  Created by webwerks on 5/16/17.
//  Copyright © 2017 neosoft. All rights reserved.
//

import UIKit

let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
let keyWindow = (UIApplication.shared.delegate as? AppDelegate)?.window

struct Constants {
    
    static let BaseServerURL = "https://api.foursquare.com/v2/"
    static let clientId = "HJARTVAQQEDPDRFHEWMX0KL1CN2OFMH3FKG0WXTR11ZMTZAE"
    static let clientSecret = "K3VWRDINVZDXUCQW5Y10OSNNLYYGDVROAWNJM4J4SX4DZCNC"
    
}

struct Message {
    static let locationErrorTitle = "Location error"
    static let locationSettings = "Allow application to access location from device settings"
    static let locationRefresh = "Error while fetching the location, Please check settings and try again"

}
