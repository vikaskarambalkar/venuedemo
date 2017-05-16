//
//  Venue.swift
//  NearBy
//
//  Created by webwerks on 5/16/17.
//  Copyright © 2017 neosoft. All rights reserved.
//

import Foundation

struct Venue {
    var venueId: String
    var name: String
    var location: Location
    
    init(jsonData: [String: Any]) {
        self.venueId = (jsonData["id"] as? String)!
        self.name = (jsonData["name"] as? String)!
        self.location = Location(jsonData: (jsonData["location"] as? [String : Any])!)
    }
}

struct Location {
    var distance: Int
    var formattedAddress = [String]()
    
    init(jsonData: [String: Any]) {
        self.distance = (jsonData["distance"] as? Int)!
        self.formattedAddress = (jsonData["formattedAddress"] as? [String])!
    }
}
